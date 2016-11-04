import UIKit


public protocol WorktableCellView {

	var cellHeight: CGFloat { get }


	func updateWithCellItem(_ cellItem: WorktableCellItem)


	func willReportCellHeight(_ controller: WorktableViewController)


	func willDisplayCell(_ controller: WorktableViewController)


	func didEndDisplayingCell(_ controller: WorktableViewController)


	func cellHighlightedWithItem(_ cellItem: WorktableCellItem)


	func cellUnhighlightedWithItem(_ cellItem: WorktableCellItem)


	func cellSelectedWithItem(_ cellItem: WorktableCellItem)


	func cellDeselectedWithItem(_ cellItem: WorktableCellItem)

}
