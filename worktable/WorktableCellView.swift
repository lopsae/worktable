import UIKit


public protocol WorktableCellView {

	var cellHeight: CGFloat { get }

	// TODO: properties to implement
//	var isSelectable: Bool { get }


	func updateWithCellItem(cellItem: WorktableCellItem)

	func willDisplayWithTable(tableView: UITableView)

	// TODO: functions to implement
//	func willEndDisplayWithTable(tableView: UITableView)

//	func cellSelectedWithItem(cellItem: WorktableCellItem)

}
