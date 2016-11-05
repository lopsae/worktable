import UIKit

public class WorktableViewController: UITableViewController {

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
	public var isRefreshing = false

	public var refreshEnabled: Bool {
		get {
			return refreshControl != nil
		}

		set {
			if let refreshControl = refreshControl {
				refreshControl.removeTarget(self, action: nil, for: .valueChanged)
			}

			if newValue {
				refreshControl = UIRefreshControl()
				refreshControl?.addTarget(self,
					action: #selector(refreshWithUserDrag),
					for: .valueChanged
				)
			} else {
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
	public var refreshDidBegin: ((WorktableViewController) -> ())?

	/// Called when a refresh using the `refreshControl` will end. At the
	/// moment of the call the `refreshControl` may be visible depending on the
	/// scroll position of the table, and afterwards will animate into idle.
	public var refreshWillEnd: ((WorktableViewController) -> ())?

	/// Called after a refresh using the refreshControl has ended. At the moment
	/// of the call the refreshControl is already hidden and idle so it can be
	/// removed safely.
	public var refreshDidEnd: ((WorktableViewController) -> ())?

	/// Used to provide a completion closure with the `scrollToTop` method.
	private var scrollToTopCompletion: (()->())?


// MARK: Cell and section register and creation

	public func registerForReuse(cellItem: WorktableCellItem) {
		switch cellItem.viewSource {
		case let .type(viewType):
			guard viewType is UITableViewCell.Type else {
				preconditionFailure("Unexpected type of viewSource: \(viewType)")
			}
			let reuseId = makeReuseIdentifier(cellItem)
			tableView.register(viewType, forCellReuseIdentifier: reuseId)

		case let .nib(nibName, bundleId):
			var bundle: Bundle?
			if bundleId != nil {
				bundle = Bundle(identifier: bundleId!)
			}
			let nib = UINib(nibName: nibName, bundle: bundle)
			let reuseId = makeReuseIdentifier(cellItem)
			tableView.register(nib, forCellReuseIdentifier: reuseId)
		}
	}


	// TODO: register function for header/footers
	// public func registerForReuse(headerItem: ??)


	private func makeReuseIdentifier(
		_ cellItem: WorktableCellItem
	) -> String {
		switch cellItem.viewSource {
		case let .type(viewType):
			return String(describing: viewType)

		case let .nib(nibName, bundleId):
			if bundleId != nil {
				return "\(bundleId)#\(nibName)"
			} else {
				return nibName
			}
		}
	}


	public func addNewSection () {
		sections.append([WorktableCellItem]())
	}


	public func pushCellItem(_ cellItem: WorktableCellItem) {
		if sections.isEmpty {
			addNewSection()
		}
		var lastSection = sections.last!
		lastSection.append(cellItem)
		sections.setLast(lastSection)
		registerForReuse(cellItem: cellItem)
	}


	public func getCellItem(at indexPath: IndexPath) -> WorktableCellItem {
		let section = sections[indexPath.section]
		return section[indexPath.row]
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
	public func getCellView(at indexPath: IndexPath) -> WorktableCellView? {
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

	private func storeCellView(
		_ cellView: WorktableCellView,
		at indexPath: IndexPath
	) {
		var sectionArray = viewsStorage[indexPath.section,
			filler:[WorktableCellView?]()
		]
		sectionArray[indexPath.row, filler: nil] = cellView
		viewsStorage[indexPath.section] = sectionArray
	}


	private func removeCellView(at indexPath: IndexPath) {
		var sectionArray = viewsStorage[indexPath.section,
			filler: [WorktableCellView?]()
		]
		sectionArray[indexPath.row, filler: nil] = nil
		viewsStorage[indexPath.section] = sectionArray
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


	/// Creates and returns the cell-view for the corresponding cell-item at 
	/// `indexPath`.
	///
	/// As cell-views are created or dequeued these are updated
	/// with the corresponding cell-item. The created cell-views are available
	/// immediately through the `getCellView(at:)` method.
	override open func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		debugPrint("created or dequeued at: \(indexPath.section),\(indexPath.row)")

		let cellItem = getCellItem(at: indexPath)
		let reuseId = makeReuseIdentifier(cellItem)
		let cellView = tableView.dequeueReusableCell(withIdentifier: reuseId)

		// The table width is updated inmediately on all cellViews to allow
		// height to be calculated during `heightForCell`
		cellView?.frame.w = tableView.bounds.w

		if let cellView = cellView as? WorktableCellView {
			cellView.updateCell(with: cellItem)
			storeCellView(cellView, at: indexPath)
		}

		return cellView!
	}


	/// Returns the estimated height of a cell before its cell-view is created.
	///
	/// This value is used to estimate the available scroll area without having
	/// to create cellViews that are not visible yet.
	///
	/// The estimated size of any cell is always provided by its corresponding
	/// cell-item. UITableViewAutomaticDimension can be used to allow the
	/// default size of cell-views or to use autolayout.
	///
	/// - Note: This method MUST exist, otherwise calling
	///   `tableView(_:cellForRowAtIndexPath:)` from within damn damdn asdasd
	///   `tableView(_:heightForRowAtIndexPath:)` causes an infinite loop.
	override open func tableView(
		_: UITableView,
		estimatedHeightForRowAt indexPath: IndexPath
	) -> CGFloat {
		let cellItem = getCellItem(at: indexPath)
		return cellItem.estimatedHeight
	}


	/// Returns the height of a given cell.
	///
	/// Before returning the height, cell-views are allowed to process their
	/// layout and thus calculate their correct height if needed.
	///
	/// - Note: The first time this method is called for each of the cells, the
	///   cell-view is still not available throught the
	///   `tableView(_:cellForRowAtIndexPath:)` method. The cell-view is stored
	///   internally and retrieved with the `getCellView(at:)` method.
	///
	/// - Note: CellViews that use autolayout should return
	///   `UITableViewAutomaticDimension`.
	override open func tableView(
		_: UITableView,
		heightForRowAt indexPath: IndexPath
	) -> CGFloat {
		if let cellView = getCellView(at: indexPath) {
			cellView.willReportCellHeight(self)
			return cellView.cellHeight
		}

		return UITableViewAutomaticDimension
	}


// MARK: Cell display and hide

	// TODO: use this method to notify cellView of its display, frame and height
	// happened before and should be correct

	/// Method called as each cellView is about to be displayed.
	override open func tableView(
		_: UITableView,
		willDisplay cellView: UITableViewCell,
		forRowAt indexPath: IndexPath
	) {
		debugPrint("will display at: \(indexPath.section),\(indexPath.row)")

		if let cellView = cellView as? WorktableCellView {
			cellView.willDisplayCell(self)
		}
	}


	override open func tableView(
		_: UITableView,
		didEndDisplaying cellView: UITableViewCell,
		forRowAt indexPath: IndexPath
	) {
		debugPrint("end display at: \(indexPath.section),\(indexPath.row)")

		if let cellView = cellView as? WorktableCellView {
			cellView.didEndDisplayingCell(self)
		}

		removeCellView(at: indexPath)
	}


// MARK: Cell selection and highlight

	override open func tableView(
		_: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		debugPrint("selected at: \(indexPath.section),\(indexPath.row)")

		let cellItem = getCellItem(at: indexPath)

		guard let cellView = getCellView(at: indexPath) else {
			return
		}

		cellItem.cellSelected(with: cellView)
		cellView.cellSelected(with: cellItem)
	}


	override open func tableView(
		_: UITableView,
		didDeselectRowAt indexPath: IndexPath
	) {
		debugPrint("deselected at: \(indexPath.section),\(indexPath.row)")

		let cellItem = getCellItem(at: indexPath)

		guard let cellView = getCellView(at: indexPath) else {
			return
		}

		cellItem.cellDeselected(with: cellView)
		cellView.cellDeselected(with: cellItem)
	}


	override open func tableView(
		_: UITableView,
		didHighlightRowAt indexPath: IndexPath
	) {
		guard let cellView = getCellView(at: indexPath) else {
			return
		}

		let cellItem = getCellItem(at: indexPath)
		cellView.cellHighlighted(with: cellItem)
	}


	override open func tableView(
		_ tableView: UITableView,
		didUnhighlightRowAt indexPath: IndexPath
	) {
		guard let cellView = getCellView(at: indexPath) else {
			return
		}

		let cellItem = getCellItem(at: indexPath)
		cellView.cellUnhighlighted(with: cellItem)
	}


// MARK: Refresh handling

	/// Method called when the `refreshControl` is activated through user
	/// interaction.
	internal func refreshWithUserDrag() {
		// TODO: dummy code to limit refresh
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
			self.endRefresh()
		}

		switchToRefreshState()
	}


	public func beginRefresh() {
		refreshControl?.beginRefreshing()
		scrollToTop()

		// TODO: dummy code to limit refresh time
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
			self.endRefresh()
		}

		switchToRefreshState()
	}


	private func switchToRefreshState() {
		isRefreshing = true
		refreshDidBegin?(self)
	}


	public func endRefresh() {
		refreshWillEnd?(self)
		self.refreshControl?.endRefreshing()
		isRefreshing = false


		// If content is already past the top, no need for scroll
		if tableView.contentOffset.y > -tableView.contentInset.top {
			refreshDidEnd?(self)
			return
		}

		// `refreshContro.endRefreshing()` will trigger scroll animations if the
		// content is at the top, except if the content was previously scrolled
		// from some position other that the top... messy and undetectable

		// Since there is no way to detect the above a scroll is issued every
		// time. If `endRefreshing()` issued a scroll it will stop automatically
		// and be replaced with this one. Thus a single call to `refreshDidEnd`
		// still happens.
		scrollToTop(animated: true) {
			[unowned self] in
			self.refreshDidEnd?(self)
		}
	}


	/// Scrolls the `tableView` to the top of the scrollable area. If the
	/// `refreshControl` is active it will be displayed as part of the scroll.
	public func scrollToTop(
		animated: Bool = true,
		completion:(()->())? = nil
	) {
		let topPoint = CGPoint(x: 0, y: -tableView.contentInset.top)
		tableView.setContentOffset(topPoint, animated: animated)
		scrollToTopCompletion = completion
	}


	override open func scrollViewDidEndScrollingAnimation(
		_ scrollView: UIScrollView
	) {
		scrollToTopCompletion?()
		scrollToTopCompletion = nil
	}


// Order of important method calls:
// viewDidLoad
// viewWillAppear
//   (before this point if any cell is requested with `tableView.cellForRow`
//   the viewDidLoad/Appear will happen before the cell is requested)
// for each cell
//  |-cellForRow
//  |-cellWillAppear
// viewDidAppear


}

