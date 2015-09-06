import UIKit


class DoubleTextCellItem: BaseCellItem {

	let NIB_NAME = "DoubleTextCellView"
	let ESTIMATED_HEIGHT: CGFloat = 75 // Based on initial height in nib file

	var labelText: String
	var buttonText: String


	init(_ labelText: String, buttonText: String) {
		self.labelText = labelText
		self.buttonText = buttonText
		super.init(viewSource: NIB_NAME, estimatedHeight: ESTIMATED_HEIGHT)

		// This would also work with the shorter init, but the difference
		// between estimatedHeight default (44) and the final height is too
		// large and causes jumping of the scroll indicator as cells are
		// creted.
//		super.init(viewSource: NIB_NAME)
	}

}
