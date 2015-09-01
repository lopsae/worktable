import UIKit


class DoubleTextCellItem: WorktableCellItem {

	let NIB_NAME = "DoubleTextCellView"

	var viewClass: AnyClass?
	var viewNib: UINib?
	var reuseIdentifier: String

	let aproximateHeight: CGFloat = 75 // Based on the nib initial height

	var labelText: String
	var buttonText: String


	init(_ labelText: String, buttonText: String) {
		viewNib = UINib(nibName: NIB_NAME, bundle: nil)
		reuseIdentifier = NIB_NAME

		self.labelText = labelText
		self.buttonText = buttonText
	}

}
