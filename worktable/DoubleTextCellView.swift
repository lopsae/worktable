import UIKit


class DoubleTextCellView: UITableViewCell, WorktableCellView {

	var cellHeight = UITableViewAutomaticDimension

	@IBOutlet weak var label: UILabel?
	@IBOutlet weak var button: UIButton?


    override func awakeFromNib() {
        super.awakeFromNib()
    }


	func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? DoubleTextCellItem {
			label?.text = cellItem.labelText
			button?.setTitle(cellItem.buttonText, forState: .Normal)
		}
	}


}
