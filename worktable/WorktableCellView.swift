import UIKit


public protocol WorktableCellView {

	var cellHeight: CGFloat { get }


	func updateWithCellItem(cellItem: WorktableCellItem)


	func willReportCellHeight(controller: WorktableViewController)


	func willDisplayCell(controller: WorktableViewController)


	func willEndDisplayingCell(controller: WorktableViewController)


	func cellHightlightedWithItem(cellItem: WorktableCellItem)


	func cellUnhightlightedWithItem(cellItem: WorktableCellItem)


	func cellSelectedWithItem(cellItem: WorktableCellItem)


	func cellDeselectedWithItem(cellItem: WorktableCellItem)

}
