import UIKit


class WorktableCellViewBase: UITableViewCell, WorktableCellView {

	var cellHeight = UITableViewAutomaticDimension


	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}


	required init(coder: NSCoder) {
		super.init(coder: coder)
	}


	func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? WorktableCellItemBase {
			textLabel?.text = cellItem.text
		}
	}

}

