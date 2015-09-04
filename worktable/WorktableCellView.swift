import UIKit


public protocol WorktableCellView {

//	var isSelectable: Bool { get }
	var cellHeight: CGFloat { get }

	// TODO to be moved to a delegate protocol?
	func updateWithCellItem(cellItem: WorktableCellItem)

	func willDisplayWithTable(tableView: UITableView)

//	func willEndDisplayWithTable(tableView: UITableView)

//	func cellSelectedWithItem(cellItem: WorktableCellItem)

}
