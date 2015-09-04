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


	func willDisplayWithTable(tableView: UITableView) {
		layoutIfNeeded()
	}


	/**
	* Upon initialization the cell frame will be set to either its default size
	* or the size provided by the nib file.
	* 
	* At some point table.configureCellForDisplay is called and with it an
	* updated frame is provided. If autolayout is being used this updated frame
	* will already consider the size of autolayed ui components.
	*
	* Later table.updateVisibleCell is called which provides an updated frame
	* for any cells that provide a custom height through the table delegage.
	*
	* Afterwards layoutSubviews is called. If size is changed during this method
	* it is necesary for the table to perform a beginUpdates-endUpdates and that
	* the cell provides the new correct height for it to be updated with an
	* animation.
	*/
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
