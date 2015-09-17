import UIKit


public protocol WorktableCellView {

	var cellHeight: CGFloat { get }

	// TODO: properties to implement
//	var isSelectable: Bool { get }


	func updateWithCellItem(cellItem: WorktableCellItem)


	func willReportCellHeight(controller: WorktableViewController)


	func willDisplayCell(controller: WorktableViewController)


	func willEndDisplayingCell(controller: WorktableViewController)


	// TODO: functions to implements
//	func cellSelectedWithItem(cellItem: WorktableCellItem)

}
