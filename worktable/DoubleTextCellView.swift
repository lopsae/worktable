import UIKit


class DoubleTextCellView: BaseCellView {

	@IBOutlet weak var label: UILabel?
	@IBOutlet weak var button: UIButton?


	override func updateWithCellItem(cellItem: WorktableCellItem) {
		super.updateWithCellItem(cellItem)
		if let cellItem = cellItem as? DoubleTextCellItem {
			label?.text = cellItem.labelText
			button?.setTitle(cellItem.buttonText, forState: .Normal)
		}
	}


	// TODO: Autlayout cell break if layoutSubvies it is called again here... come on
	// maybe layout can be skipped if height is automatic?
	override func willDisplayWithTable(tableView: UITableView) {}

}
