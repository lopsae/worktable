import UIKit


class VariableHeightCellView: UITableViewCell, WorktableCellView {

	var cellHeight = UITableViewAutomaticDimension


	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}


	required init(coder: NSCoder) {
		super.init(coder: coder)
	}


	func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? VariableHeightCellItem {
			cellHeight = cellItem.height
		}
	}


//	override var frame: CGRect {
//		get {
//			return super.frame
//		}
//
//		set (newFrame) {
//			super.frame = newFrame
//		}
//	}


//	override func layoutSubviews() {
//		super.layoutSubviews()
//	}


//	override func setNeedsLayout() {
//		super.setNeedsLayout()
//	}

}
