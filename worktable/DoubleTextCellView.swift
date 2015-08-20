import UIKit


class DoubleTextCellView: UITableViewCell, WorktableCellView {


	@IBOutlet weak var label: UILabel?
	@IBOutlet weak var button: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


	func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? DoubleTextCellItem {
			label?.text = cellItem.labelText
			button?.setTitle(cellItem.buttonText, forState: .Normal)
		}
	}

    
}
