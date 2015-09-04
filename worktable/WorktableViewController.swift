import UIKit


public class WorktableViewController: UITableViewController {

	private var sections = [[WorktableCellItem]]()

	// TODO support refreshing
//	public var isRefreshing = false
//	public var refreshEnabled = false


	public func registerViewIdentifiers(cellItem: WorktableCellItem) {
		if cellItem.viewNib != nil {
			tableView.registerNib(cellItem.viewNib!,
				forCellReuseIdentifier: cellItem.reuseIdentifier)
			return
		}

		if cellItem.viewClass != nil {
			tableView.registerClass(cellItem.viewClass!,
				forCellReuseIdentifier: cellItem.reuseIdentifier)
			return
		}
	}


	public func addNewSection () {
		sections.append([WorktableCellItem]())
	}


	public func pushCellItem(cellItem: WorktableCellItem) {
		if sections.last == nil {
			addNewSection()
		}
		var lastSection = sections.tail!
		lastSection.append(cellItem)
		sections.tail = lastSection
		registerViewIdentifiers(cellItem)
	}


	public func cellItemAtIndexPath(indexPath: NSIndexPath)
	-> WorktableCellItem {
		let section = sections[indexPath.section]
		return section[indexPath.row]
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


	override public func tableView(
		tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath
	) -> UITableViewCell {
		let cellItem = cellItemAtIndexPath(indexPath)
		let cellView = tableView.dequeueReusableCellWithIdentifier(cellItem.reuseIdentifier)
			as! UITableViewCell

		if let cellView = cellView as? WorktableCellView {
			cellView.updateWithCellItem(cellItem)
		}
		return cellView
	}


	/**
	* Returns the estimated height of a cell before its cellView is created.
	* This value is used to estimate the available scroll area without having to
	* create cellViews that are not visible yet.
	*
	* The estimated size of any cell is always provided by it corresponding
	* cellItem. UITableViewAutomaticDimension can be used to allow the default
	* size of cellViews or to use autolayout.
	*
	* This method must exist, otherwise calling tableView::cellForRowAtIndexPath
	* from within heightForRowAtIndexPath causes an infinite loop.
	*/
	override public func tableView(_: UITableView,
		estimatedHeightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		let cellItem = cellItemAtIndexPath(indexPath)
		return cellItem.estimatedHeight
	}


	/**
	* Returns the height of a given cell.
	*
	* This method is called during creation of each of the cellViews, at that
	* point the cellView is not available through the tableView object and the
	* estimatedHeight value of the cellItem is used.
	*
	* When the estimatedHeight and height are the same during the cellView
	* creation the height wil be requested again before the cellView is finally
	* displayed.
	*
	* The willDisplayCell delegate method is used to allow cellViews to update
	* their layouts. Afterwards the height is requested again and the height
	* returned by the cellView object is used. This allows cellViews to update
	* their height during creation without the need to call reloadData in the
	* tableView object.
	*/
	override public func tableView(_: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		// TODO when deleting or inserting new cells, what does cellForRow returns?
		// cell state before the change? after the change?
		var cellView = tableView.cellForRowAtIndexPath(indexPath)
		if let cellView = cellView as? WorktableCellView {
			return cellView.cellHeight
		}
		return self.tableView(tableView,
			estimatedHeightForRowAtIndexPath: indexPath
		)
	}


	/**
	* Method called as each cellView is about to be displayed.
	* 
	* At this point the table has already requested the height of the cellView
	* and the frame has been set to the correct size using the requested height.
	*
	* cellView::willDisplayWithTable is called to allow cellViews that manage
	* their own layout through to adjust their subviews and update their height,
	* or to do any other last chance update before display.
	*
	* After this method is called the cellView is availble to request through
	* the tableView object. The height of the cell is requested again allowing
	* to use the correct height returned by the cellView.
	*/
	override public func tableView(_: UITableView,
		willDisplayCell cellView: UITableViewCell,
		forRowAtIndexPath indexPath: NSIndexPath
	) {
		if let cellView = cellView as? WorktableCellView {
			return cellView.willDisplayWithTable(tableView)
		}
	}


	override public func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		// TODO: only do if we detect that cells need resizing?

		// begin-endUpdates animates the cell height change, possible all of them
		// what happens if cells become visible or out of view?
//		tableView.beginUpdates()
//		tableView.endUpdates()

		// reload data corrects heights changes, but requests all cellsViews
		// again and does not have animation
		// all cellViews are recreated, but size is checked until after
		// layoutSubviews is called! So in this specific case cell have the
		// chance to adjust their layout and size and the table grabs it properly
//		tableView.reloadData()

		// reloadRows animates size change and slides a new cell with an animation
//		tableView.reloadRowsAtIndexPaths([temporaryIndexPath!], withRowAnimation: .Right)
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

}

