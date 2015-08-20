import UIKit


class DoubleTextCellItem: WorktableCellItem {

	var viewClass: AnyClass?
	var viewNib: UINib?
	var reuseIdentifier: String

	var labelText: String
	var buttonText: String


	init(_ labelText: String, buttonText: String) {
		viewNib = UINib(nibName: "DoubleTextCellView", bundle: nil)
		reuseIdentifier = "DoubleTextCellView"

		self.labelText = labelText
		self.buttonText = buttonText
	}

}
