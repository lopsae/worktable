import UIKit


public class WorktableViewController: UITableViewController {

	private var sections = [[WorktableCellItem]]()

	/**
	Internal storage of cellViews as they are created. Mainly used to allow
	cellViews to perform their own layout before the height for the cell is
	requested. The method `tableView::cellForRowAtIndexPath` does not return
	the created cellViews when the height is requested neither during the
	initial table load, nor when new cellsViews are created during scrolling.
	*/
	private var cellViews = [[WorktableCellView?]]()

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

		assertionFailure("Unexpected type of viewSource to register for reuse")
	}


	internal func reuseIdentifierForCellItem(
		cellItem: WorktableCellItem
	) -> String? {
		if let nibName = cellItem.cellViewSource as? String {
			return nibName
		}

		if cellItem.cellViewSource is UITableViewCell.Type {
			return toString(cellItem.cellViewSource)
		}

		assertionFailure("Unexpected type of viewSource")
		return nil
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



	public func cellViewAtIndexPath(indexPath: NSIndexPath)
	-> WorktableCellView? {
		return cellViews[indexPath.section][indexPath.row]
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


	/**
	Creates and returns the cellView for the cellItem corresponding to the given
	`indexPath`. As cellViews are created or dequeued they are updated with the
	corresponding cellItem. The created cellViews are available inmediately
	through the instance `cellViewForIndexPath` method.
	*/
	override public func tableView(
		tableView: UITableView,
		cellForRowAtIndexPath indexPath: NSIndexPath
	) -> UITableViewCell {
		let cellItem = cellItemAtIndexPath(indexPath)
		let reuseId = reuseIdentifierForCellItem(cellItem)
		let cellView = tableView.dequeueReusableCellWithIdentifier(reuseId!)
			as! UITableViewCell

		if let cellView = cellView as? WorktableCellView {
			cellView.updateWithCellItem(cellItem)

			var sectionArray = cellViews[indexPath.section,
				filler: [WorktableCellView?]()
			]
			sectionArray[indexPath.row, filler: nil] = cellView
			cellViews[indexPath.section] = sectionArray
		}

		return cellView
	}


	/**
	Returns the estimated height of a cell before its cellView is created.
	
	This value is used to estimate the available scroll area without having to
	create cellViews that are not visible yet.

	The estimated size of any cell is always provided by it corresponding
	cellItem. UITableViewAutomaticDimension can be used to allow the default
	size of cellViews or to use autolayout.

	This method must exist, otherwise calling tableView::cellForRowAtIndexPath
	from within heightForRowAtIndexPath causes an infinite loop.
	*/
	override public func tableView(_: UITableView,
		estimatedHeightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		let cellItem = cellItemAtIndexPath(indexPath)
		return cellItem.cellEstimatedHeight
	}


	/**
	Returns the height of a given cell.
	
	The first time this method is called for each of the cells, the cellView is
	still not available throught the `tableView.cellForRowAtIndexPath` method.
	Thus the cellView is stored internally and retrieved by the instance
	`cellViewAtIndexPath` method.
	
	Before returning the height, cellViews are allowed to process their layout
	and thus calculate their correct height if needed.
	*/
	// TODO: check if the frame size is correctly set by the time we allow cells to do their layout
	override public func tableView(_: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		if let cellView = cellViews[indexPath.section][indexPath.row] {
			// TODO: better event name like: preHeightRequest
			// TODO: is this being called several times during initial population
			// is it being called when the frame has not yet been set correctly?
			cellView.willDisplayWithTable(tableView)
			return cellView.cellHeight
		}

		return self.tableView(tableView,
			estimatedHeightForRowAtIndexPath: indexPath
		)
	}


	/**
	Method called as each cellView is about to be displayed.

	TODO: figure out if this method is still useful, since layout is happening inside heightForRowAt
	*/
	override public func tableView(_: UITableView,
		willDisplayCell cellView: UITableViewCell,
		forRowAtIndexPath indexPath: NSIndexPath
	) {
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

