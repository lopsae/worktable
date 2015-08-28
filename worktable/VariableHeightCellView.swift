import UIKit


class VariableHeightCellView: UITableViewCell, WorktableCellView {

	var cellHeight = UITableViewAutomaticDimension
	var definedHeight: CGFloat = -1

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
			definedHeight = cellItem.height
			cellHeight = cellItem.height
			setNeedsLayout()
		}
	}


	override func layoutSubviews() {
		var newBounds = bounds
		newBounds.size.height = definedHeight * 2
		bounds = newBounds

		cellHeight = bounds.height
		dummyView.frame = bounds

		super.layoutSubviews()
	}


// For debugging
	
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
