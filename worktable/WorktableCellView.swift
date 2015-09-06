import UIKit


public protocol WorktableCellView {

//	var isSelectable: Bool { get }
	var cellHeight: CGFloat { get }


	func updateWithCellItem(cellItem: WorktableCellItem)

	func willDisplayWithTable(tableView: UITableView)

	// TODO: functions to implement
//	func willEndDisplayWithTable(tableView: UITableView)

//	func cellSelectedWithItem(cellItem: WorktableCellItem)

}
