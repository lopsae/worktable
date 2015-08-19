import UIKit


public class WorktableViewController: UITableViewController {

	private var sections = [[WorktableCellItem]]()

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


	public func cellItemAtIndexPath(indexPath: NSIndexPath) -> WorktableCellItem {
		let section = sections[indexPath.section]
		return section[indexPath.row]
	}


	override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return sections.count
	}


	override public func tableView(tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
		return sections[sectionIndex].count
	}


	override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cellItem = cellItemAtIndexPath(indexPath)
		let cellView = tableView.dequeueReusableCellWithIdentifier(cellItem.reuseIdentifier)
			as! UITableViewCell

//		if let worktableCellView = cellView as? WorktableCellView {
//			worktableCellView.updateWithItem(cellItem)
//		}
		return cellView
	}

}

