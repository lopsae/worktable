import UIKit


open class WorktableViewController: UITableViewController {

	private var sections = [[WorktableCellItem]]()


	/// Internal storage of cellViews as they are created.
	///
	/// Used to allow cellViews to perform their own layout before the height
	/// for the cell is returned. The method `tableView::cellForRowAtIndexPath`
	/// fails to return the created cellViews at the time when the height is
	/// requested. This happens for both cellViews created during the initial
	/// table load and during scrolling.
	private var viewsStorage = [[WorktableCellView?]]()

	private(set)
	open var isRefreshing = false

	open var refreshEnabled: Bool {
		get {
			return refreshControl != nil
		}

		set {
			if newValue {
				// TODO: respect refresh control if one is already there
				refreshControl = UIRefreshControl()
				refreshControl?.addTarget(self,
					action: #selector(WorktableViewController.refreshWithDrag),
					for: .valueChanged
				)
			} else {
				// If refresh control is removed at any time before it being
				// used (beginRefresh and endRefresh being called), a warning
				// will be printed.
				// After it has been used at least once it can be removed
				// without warning whenever the control is not being used.
				// Removing the control with the `refreshDidEnd` callback works
				// properly.
				refreshControl = nil
			}
		}
	}


// MARK: Events closures

	/// Called when a refresh using the `refreshControl` has begun. If the
	/// refresh start with a user gesture, then the `refreshControl` will be
	/// already visible. If the refresh started through a call to the
	/// `beginRefresh` method, then the `refreshControl` will be about to scroll
	/// into display.
	open var refreshDidBegin: ((WorktableViewController) -> ())?

	/// Called when a refresh using the `refreshControl` will end. At the
	/// moment of the call the `refreshControl` may be visible depending on the
	/// scroll position of the table, and afterwards will animate into idle.
	open var refreshWillEnd: ((WorktableViewController) -> ())?

	/// Called after a refresh using the refreshControl has ended. At the moment
	/// of the call the refreshControl is already hidden and idle so it can be
	/// removed safely.
	open var refreshDidEnd: ((WorktableViewController) -> ())?

	private var transientScrollAnimationDidEnd: (()->())?


// MARK: Cell and section register and creation

	open func registerCellItemForReuse(_ cellItem: WorktableCellItem) {
		if let nibName = cellItem.cellViewSource as? String {
			// TODO: string could have special format to allow bundle
			// say, separate with # or character not allowed in nib/bundle names
			let nib = UINib(nibName: nibName, bundle: nil);
			let reuseId = reuseIdentifierForCellItem(cellItem)
			tableView.register(nib, forCellReuseIdentifier: reuseId!)
			return
		}

		if let cellViewClass = cellItem.cellViewSource as? UITableViewCell.Type {
			let reuseId = reuseIdentifierForCellItem(cellItem)
			tableView.register(cellViewClass,
				forCellReuseIdentifier: reuseId!
			)
			return
		}

		preconditionFailure("Unexpected type of viewSource to register for reuse: \(cellItem.cellViewSource)")
	}


	private func reuseIdentifierForCellItem(
		_ cellItem: WorktableCellItem
	) -> String? {
		if let nibName = cellItem.cellViewSource as? String {
			return nibName
		}

		if cellItem.cellViewSource is UITableViewCell.Type {
			return String(describing: cellItem.cellViewSource)
		}

		preconditionFailure("Unexpected type of viewSource: \(cellItem.cellViewSource)")
	}


	open func addNewSection () {
		sections.append([WorktableCellItem]())
	}


	open func pushCellItem(_ cellItem: WorktableCellItem) {
		if sections.isEmpty {
			addNewSection()
		}
		var lastSection = sections.last!
		lastSection.append(cellItem)
		sections.setLast(lastSection)
		registerCellItemForReuse(cellItem)
	}


	open func cellItemAtIndexPath(_ indexPath: IndexPath)
	-> WorktableCellItem {
		let section = sections[(indexPath as NSIndexPath).section]
		return section[(indexPath as NSIndexPath).row]
	}


	// TODO: add to documentation
	// TODO: test whan happens if cells are to be displayed as calculated by
	// estimated height, but then fail to appear as these are pushed out of view
	// by actual heights.
	//
	// on very specific cases a cell may be returned here that is not yet displayed
	// and thus could be reused in different position.
	// during init, if cells grow, some other cells can become pushed out of visibility
	// in this case the cellView may be created, but ultimately never displayed
	// and this cell may be later reused in the same or different position
	// the only assumption that can be made for this method is that it returns
	// the last cell created for the given indexPath, regardless of if it was displayed or not
	open func cellViewAtIndexPath(_ indexPath: IndexPath)
	-> WorktableCellView? {
		guard let anyElement = viewsStorage.follow(path: indexPath) else {
			// Tried to access an unexisting position
			return nil
		}

		guard let maybeCellView = anyElement as? OptionalProtocol else {
			// Not an WorktableCellView? element, supposedly imposible
			return nil
		}

		if maybeCellView.isNone() {
			// Position in array exist, but nothing stored there
			return nil
		}
	
		return maybeCellView.unwrap() as? WorktableCellView
	}

// MARK: Cell private storage handlers

	private func storeCellView(_ cellView: WorktableCellView,
		indexPath: IndexPath
	) {
		var sectionArray = viewsStorage[(indexPath as NSIndexPath).section,
			filler:[WorktableCellView?]()
		]
		sectionArray[(indexPath as NSIndexPath).row, filler: nil] = cellView
		viewsStorage[(indexPath as NSIndexPath).section] = sectionArray
	}


	private func clearCellView(indexPath: IndexPath) {
		var sectionArray = viewsStorage[(indexPath as NSIndexPath).section,
			filler: [WorktableCellView?]()
		]
		sectionArray[(indexPath as NSIndexPath).row, filler: nil] = nil
		viewsStorage[(indexPath as NSIndexPath).section] = sectionArray
	}


// MARK: Table data source methods

	override open func numberOfSections(in tableView: UITableView)
	-> Int {
		return sections.count
	}


	override open func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection sectionIndex: Int
	) -> Int {
		return sections[sectionIndex].count
	}


	/// Creates and returns the cellView for the cellItem corresponding to the
	/// given `indexPath`. As cellViews are created or dequeued they are updated
	/// with the corresponding cellItem. The created cellViews are available
	/// immediately through the instance `cellViewForIndexPath` method.
	override open func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		debugPrint("created or dequeued at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		let cellItem = cellItemAtIndexPath(indexPath)
		let reuseId = reuseIdentifierForCellItem(cellItem)
		let cellView = tableView.dequeueReusableCell(withIdentifier: reuseId!)

		// The table width is updated inmediately on all cellViews to allow
		// height to be calculated during `heightForCell`
		cellView?.frame.w = tableView.bounds.w

		if let cellView = cellView as? WorktableCellView {
			cellView.updateWithCellItem(cellItem)
			storeCellView(cellView, indexPath: indexPath)
		}

		return cellView!
	}


	/// Returns the estimated height of a cell before its cellView is created.
	///
	/// This value is used to estimate the available scroll area without having
	/// to create cellViews that are not visible yet.
	///
	/// The estimated size of any cell is always provided by its corresponding
	/// cellItem. UITableViewAutomaticDimension can be used to allow the default
	/// size of cellViews or to use autolayout.
	///
	/// This method must exist, otherwise calling
	/// `tableView::cellForRowAtIndexPath` from within `heightForRowAtIndexPath`
	/// causes an infinite loop.
	override open func tableView(_: UITableView,
		estimatedHeightForRowAt indexPath: IndexPath
	) -> CGFloat {
		let cellItem = cellItemAtIndexPath(indexPath)
		return cellItem.cellEstimatedHeight
	}


	/// Returns the height of a given cell.
	///
	/// The first time this method is called for each of the cells, the cellView
	/// is still not available throught the `tableView.cellForRowAtIndexPath`
	/// method. Thus the cellView is stored internally and retrieved by the
	/// instance `cellViewAtIndexPath` method.
	///
	/// Before returning the height, cellViews are allowed to process their
	/// layout and thus calculate their correct height if needed.
	///
	/// CellViews that use autolayout should return
	/// `UITableViewAutomaticDimension` to properly adjust themselves.
	override open func tableView(_: UITableView,
		heightForRowAt indexPath: IndexPath
	) -> CGFloat {
		if let cellView = cellViewAtIndexPath(indexPath) {
			cellView.willReportCellHeight(self)
			return cellView.cellHeight
		}

		return UITableViewAutomaticDimension
	}


// MARK: Cell display and hide

	// TODO: use this method to notify cellView of its display, frame and height
	// happened before and should be correct

	/// Method called as each cellView is about to be displayed.
	override open func tableView(_: UITableView,
		willDisplay cellView: UITableViewCell,
		forRowAt indexPath: IndexPath
	) {
		debugPrint("will display at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		if let cellView = cellView as? WorktableCellView {
			cellView.willDisplayCell(self)
		}
	}


	override open func tableView(_: UITableView,
		didEndDisplaying cellView: UITableViewCell,
		forRowAt indexPath: IndexPath
	) {
		debugPrint("end display at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		if let cellView = cellView as? WorktableCellView {
			cellView.didEndDisplayingCell(self)
		}

		clearCellView(indexPath: indexPath)
	}


// MARK: Cell selection and highlight

	override open func tableView(_: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		debugPrint("selected at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		let cellItem = cellItemAtIndexPath(indexPath)
		let cellView = cellViewAtIndexPath(indexPath)

		cellItem.cellSelectedWithView(cellView)

		if let cellView = cellView {
			cellView.cellSelectedWithItem(cellItem)
		}
	}


	override open func tableView(_: UITableView,
		didDeselectRowAt indexPath: IndexPath
	) {
		debugPrint("deselected at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		let cellItem = cellItemAtIndexPath(indexPath)
		let cellView = cellViewAtIndexPath(indexPath)

		cellItem.cellDeselectedWithView(cellView)

		if let cellView = cellView {
			cellView.cellDeselectedWithItem(cellItem)
		}
	}


	override open func tableView(_: UITableView,
		didHighlightRowAt indexPath: IndexPath
	) {
		debugPrint("highlighed at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		if let cellView = cellViewAtIndexPath(indexPath) {
			let cellItem = cellItemAtIndexPath(indexPath)
			cellView.cellHightlightedWithItem(cellItem)
		}
	}


	override open func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
		debugPrint("unhighlighed at: \((indexPath as NSIndexPath).section),\((indexPath as NSIndexPath).row)")

		if let cellView = cellViewAtIndexPath(indexPath) {
			let cellItem = cellItemAtIndexPath(indexPath)
			cellView.cellUnhightlightedWithItem(cellItem)
		}
	}


// MARK: Refresh handling

	/// Method called when the `refreshControl` is activated through user
	/// interaction.
	internal func refreshWithDrag() {
		debugPrint("refresh started by drag")

		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
			self.endRefresh()
		}

		switchToRefreshState()
	}


	open func beginRefresh() {
		debugPrint("refresh started by code")

		refreshControl?.beginRefreshing()
		scrollToTop()

		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
			self.endRefresh()
		}

		switchToRefreshState()
	}


	private func switchToRefreshState() {
		isRefreshing = true
		refreshDidBegin?(self)
	}


	open func endRefresh() {
		refreshWillEnd?(self)
		self.refreshControl?.endRefreshing()
		isRefreshing = false;


		// If content is already past the top, no need for scroll
		if tableView.contentOffset.y > -tableView.contentInset.top {
			refreshDidEnd?(self)
			return;
		}

		// `refreshContro.endRefreshing()` will trigger scroll animations if the
		// content is at the top, except if the content was previously scrolled
		// from some position other that the top... messy and undetectable

		// Since there is no way to detect the above a scroll is issued every
		// time. If `endRefreshing()` issued a scroll it will stop automatically
		// and be replaced with this one.
		debugPrint("starting scroll")
		scrollToTop(animated: true) {
			[unowned self] in
			self.refreshDidEnd?(self)
		}

		debugPrint("scroll started")
	}


	/// Scrolls the `tableView` to the top of the scrollable area. If the
	/// `refreshControl` is active it will be displayed as part of the scroll.
	open func scrollToTop(animated: Bool = true, completition:(()->())? = nil) {
		let topPoint = CGPoint(x: 0, y: -tableView.contentInset.top)
		tableView.setContentOffset(topPoint, animated: animated)
		transientScrollAnimationDidEnd = completition
	}


	override open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		transientScrollAnimationDidEnd?()
		transientScrollAnimationDidEnd = nil
	}


// Order of important method calls:
// viewDidLoad
// viewWillAppear
// (before this, if a cell is requested by tableView.cellForRow the whole block happens right there)
// for each cell
//  |-cellForRow
//  |-cellWillAppear
// viewDidAppear


// MARK: Debugging methods

//	override public func scrollViewDidScroll(scrollView: UIScrollView) {
//		debugPrint("scrolling")
//	}


//	override public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//		debugPrint("view end deceleration")
//	}


	// happens before any requests for cell views
	// this is why it is usualy used to populate cellItems
	override open func viewDidLoad() {
		super.viewDidLoad()
	}


	// also happens before any cellViews are requested
	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}


	override open func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}

}

