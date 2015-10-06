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

	// TODO: for future refresh support
//	public var isRefreshing = false
//	public var refreshEnabled = false


	public func registerCellItemForReuse(cellItem: WorktableCellItem) {
		if let nibName = cellItem.cellViewSource as? String {
			// TODO: string could have special format to allow bundle
			// say, separate with # or character not allowed in nib/bundle names
			let nib = UINib(nibName: nibName, bundle: nil);
			let reuseId = reuseIdentifierForCellItem(cellItem)
			tableView.registerNib(nib, forCellReuseIdentifier: reuseId!)
			return
		}

		if let cellViewClass = cellItem.cellViewSource as? UITableViewCell.Type {
			let reuseId = reuseIdentifierForCellItem(cellItem)
			tableView.registerClass(cellViewClass,
				forCellReuseIdentifier: reuseId!
			)
			return
		}

		preconditionFailure("Unexpected type of viewSource to register for reuse: \(cellItem.cellViewSource)")
	}


	private func reuseIdentifierForCellItem(
		cellItem: WorktableCellItem
	) -> String? {
		if let nibName = cellItem.cellViewSource as? String {
			return nibName
		}

		if cellItem.cellViewSource is UITableViewCell.Type {
			return String(cellItem.cellViewSource)
		}

		preconditionFailure("Unexpected type of viewSource: \(cellItem.cellViewSource)")
	}


	public func addNewSection () {
		sections.append([WorktableCellItem]())
	}


	public func pushCellItem(cellItem: WorktableCellItem) {
		if sections.isEmpty {
			addNewSection()
		}
		var lastSection = sections.last!
		lastSection.append(cellItem)
		sections.setLast(lastSection)
		registerCellItemForReuse(cellItem)
	}


	public func cellItemAtIndexPath(indexPath: NSIndexPath)
	-> WorktableCellItem {
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
	public func cellViewAtIndexPath(indexPath: NSIndexPath)
	-> WorktableCellView? {
		guard let anyElement = viewsStorage[indexPath.toArray()] else {
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


	private func storeCellView(cellView: WorktableCellView,
		indexPath: NSIndexPath
	) {
		var sectionArray = viewsStorage[indexPath.section,
			filler:[WorktableCellView?]()
		]
		sectionArray[indexPath.row, filler: nil] = cellView
		viewsStorage[indexPath.section] = sectionArray
	}


	private func clearCellView(indexPath indexPath: NSIndexPath) {
		var sectionArray = viewsStorage[indexPath.section,
			filler: [WorktableCellView?]()
		]
		sectionArray[indexPath.row, filler: nil] = nil
		viewsStorage[indexPath.section] = sectionArray
	}


	override public func numberOfSectionsInTableView(tableView: UITableView)
	-> Int {
		return sections.count
	}


	override public func tableView(
		tableView: UITableView,
		numberOfRowsInSection sectionIndex: Int
	) -> Int {
		return sections[sectionIndex].count
	}


	/// Creates and returns the cellView for the cellItem corresponding to the
	/// given `indexPath`. As cellViews are created or dequeued they are updated
	/// with the corresponding cellItem. The created cellViews are available
	/// immediately through the instance `cellViewForIndexPath` method.
	override public func tableView(
		tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath
	) -> UITableViewCell {
		debugPrint("created or dequeued at: \(indexPath.section),\(indexPath.row)")

		let cellItem = cellItemAtIndexPath(indexPath)
		let reuseId = reuseIdentifierForCellItem(cellItem)
		let cellView = tableView.dequeueReusableCellWithIdentifier(reuseId!)

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
	override public func tableView(_: UITableView,
		estimatedHeightForRowAtIndexPath indexPath: NSIndexPath
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
	override public func tableView(_: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		if let cellView = cellViewAtIndexPath(indexPath) {
			cellView.willReportCellHeight(self)
			return cellView.cellHeight
		}

		return UITableViewAutomaticDimension
	}


	// TODO: use this method to notify cellView of its display, frame and height
	// happened before and should be correct
	// TODO: implement cell that height changes after display, with animation
	// and without

	/// Method called as each cellView is about to be displayed.
	override public func tableView(_: UITableView,
		willDisplayCell cellView: UITableViewCell,
		forRowAtIndexPath indexPath: NSIndexPath
	) {
		debugPrint("will display at: \(indexPath.section),\(indexPath.row)")

		if let cellView = cellView as? WorktableCellView {
			cellView.willDisplayCell(self)
		}
	}


	override public func tableView(_: UITableView,
		didEndDisplayingCell cellView: UITableViewCell,
		forRowAtIndexPath indexPath: NSIndexPath
	) {
		debugPrint("end display at: \(indexPath.section),\(indexPath.row)")

		if let cellView = cellView as? WorktableCellView {
			cellView.didEndDisplayingCell(self)
		}

		clearCellView(indexPath: indexPath)
	}


	override public func tableView(_: UITableView,
		didSelectRowAtIndexPath indexPath: NSIndexPath
	) {
		debugPrint("selected at: \(indexPath.section),\(indexPath.row)")

		let cellItem = cellItemAtIndexPath(indexPath)
		let cellView = cellViewAtIndexPath(indexPath)

		cellItem.cellSelectedWithView(cellView)

		if let cellView = cellView {
			cellView.cellSelectedWithItem(cellItem)
		}
	}


	override public func tableView(_: UITableView,
		didDeselectRowAtIndexPath indexPath: NSIndexPath
	) {
		debugPrint("deselected at: \(indexPath.section),\(indexPath.row)")

		let cellItem = cellItemAtIndexPath(indexPath)
		let cellView = cellViewAtIndexPath(indexPath)

		cellItem.cellDeselectedWithView(cellView)

		if let cellView = cellView {
			cellView.cellDeselectedWithItem(cellItem)
		}
	}


	override public func tableView(_: UITableView,
		didHighlightRowAtIndexPath indexPath: NSIndexPath
	) {
		debugPrint("highlighed at: \(indexPath.section),\(indexPath.row)")

		if let cellView = cellViewAtIndexPath(indexPath) {
			let cellItem = cellItemAtIndexPath(indexPath)
			cellView.cellHightlightedWithItem(cellItem)
		}
	}


	override public func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
		debugPrint("unhighlighed at: \(indexPath.section),\(indexPath.row)")

		if let cellView = cellViewAtIndexPath(indexPath) {
			let cellItem = cellItemAtIndexPath(indexPath)
			cellView.cellUnhightlightedWithItem(cellItem)
		}
	}


	// For debugging

	// happens before any requests for cell views
	// this is why it is usualy used to populate cellItems
	override public func viewDidLoad() {
		super.viewDidLoad()
	}


	// also happens before any cellViews are requested
	override public func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}


	override public func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}

}

