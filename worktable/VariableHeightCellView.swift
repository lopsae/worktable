import UIKit


class VariableHeightCellView: UITableViewCell, WorktableCellView {

	var cellHeight = UITableViewAutomaticDimension

	var dummyView: DummyView


	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		dummyView = DummyView(frame: CGRectZero)
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		contentView.addSubview(dummyView)
	}


	required init(coder: NSCoder) {
		dummyView = DummyView(frame: CGRectZero)
		super.init(coder: coder)

		contentView.addSubview(dummyView)
	}


	func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? VariableHeightCellItem {
			cellHeight = cellItem.height
		}
	}


	override func layoutSubviews() {
		super.layoutSubviews()
		dummyView.frame = bounds
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


//	override func setNeedsLayout() {
//		super.setNeedsLayout()
//	}

}
