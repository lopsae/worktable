import UIKit


/// Example CellItem for a cell that reports a given `estimatedHeight`, and
/// duplicates its height upon display.
class VariableHeightCellItem: BaseCellItem {

	let VIEW_CLASS = VariableHeightCellView.self

	var initialHeight: CGFloat


	init(initialHeight: CGFloat) {
		self.initialHeight = initialHeight
		super.init(
			type: VIEW_CLASS,
			estimatedHeight: initialHeight
		)
	}

}
