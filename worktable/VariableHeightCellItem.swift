import UIKit


class VariableHeightCellItem: BaseCellItem {

	let VIEW_CLASS = VariableHeightCellView.self

	var initialHeight: CGFloat


	init(initialHeight: CGFloat) {
		self.initialHeight = initialHeight
		super.init(viewSource: VIEW_CLASS, estimatedHeight: initialHeight)
	}

}
