import UIKit


class VariableHeightCellItem: WorktableCellItem {

	let REUSE_IDENTIFIER = "VariableHeightCellItem"

	var viewClass: AnyClass?
	var viewNib: UINib?
	var reuseIdentifier: String

	var estimatedHeight: CGFloat
	var height: CGFloat


	init(_ initialHeight: CGFloat) {
		viewClass = VariableHeightCellView.self
		reuseIdentifier = REUSE_IDENTIFIER

		estimatedHeight = initialHeight
		height = initialHeight
	}

}
