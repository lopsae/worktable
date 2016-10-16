import UIKit


class AutolayoutCellView: BaseCellView {

	@IBOutlet weak var label: UILabel?
	@IBOutlet weak var button: UIButton?


	override func updateWithCellItem(_ cellItem: WorktableCellItem) {
		super.updateWithCellItem(cellItem)
		if let cellItem = cellItem as? AutolayoutCellItem {
			label?.text = cellItem.labelText
			button?.setTitle(cellItem.buttonText, for: UIControlState())
		}
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

}
