import UIKit


class DoubleTextCellItem: BaseCellItem {

	let NIB_NAME = "DoubleTextCellView"
	let ESTIMATED_HEIGHT: CGFloat = 75

	var labelText: String
	var buttonText: String


	init(_ labelText: String, buttonText: String) {
		self.labelText = labelText
		self.buttonText = buttonText
		super.init(viewSource: NIB_NAME, estimatedHeight: ESTIMATED_HEIGHT)

		// Also works with shorter init, but if the expanded cell is too big the
		// scrolling bar jumps around as cells are created
//		super.init(viewSource: NIB_NAME)
	}

}
