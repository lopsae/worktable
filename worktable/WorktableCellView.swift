import UIKit


public protocol WorktableCellView {

	var cellHeight: CGFloat { get }


	func updateCell(with cellItem: WorktableCellItem)


	func willReportCellHeight(_ controller: WorktableViewController)


	func willDisplayCell(_ controller: WorktableViewController)


	func didEndDisplayingCell(_ controller: WorktableViewController)


// MARK: Hightlight and selection

	func cellHighlighted(with cellItem: WorktableCellItem)


	func cellUnhighlighted(with cellItem: WorktableCellItem)


	func cellSelected(with cellItem: WorktableCellItem)


	func cellDeselected(with cellItem: WorktableCellItem)

}
