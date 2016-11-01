import UIKit


/// Example cellItem for a cell that adjust its size through autolayout.
class AutolayoutCellItem: BaseCellItem {

	let NIB_NAME = "AutolayoutCellView"

	// Based on initial height in nib file
	// Using the default would also work but if the height difference is too
	// large there is jumping of the scroll indicator as scrolling happens
	let ESTIMATED_HEIGHT: CGFloat = 75

	var labelText: String
	var buttonText: String


	init(_ labelText: String, buttonText: String) {
		self.labelText = labelText
		self.buttonText = buttonText
		super.init(
			nibName: NIB_NAME,
			bundleId: nil,
			estimatedHeight: ESTIMATED_HEIGHT
		)
	}

}
