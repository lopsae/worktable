import UIKit


public class WorktableViewController: UITableViewController {

	public static let DEFAULT_ESTIMATED_HEIGHT: CGFloat = 44

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


	override public func tableView(
		tableView: UITableView,
		estimatedHeightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		return 75
		let cellItem = cellItemAtIndexPath(indexPath)
		return cellItem.aproximateHeight
	}


	override public func tableView(
		tableView: UITableView,
		heightForRowAtIndexPath indexPath: NSIndexPath
	) -> CGFloat {
		var cellView = tableView.cellForRowAtIndexPath(indexPath)
		if let cellView = cellView as? WorktableCellView {
			return cellView.cellHeight
		}
		return UITableViewAutomaticDimension
	}


	override public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		// When a table is redisplayed the cell are not requested again. Right
		// now they are because a reloadData is being issued

		// seems like this method is called before the height is checked, but
		// after the frame with the right width is set
		// thus it might be usable for doing layout for coded-layout cells so
		// that these are ready upon first display

		// TODO: this method should triger layoutSubviews for code cellViews!
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
		tableView.reloadData()

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

