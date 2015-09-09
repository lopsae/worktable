import UIKit


class AutolayoutCellView: BaseCellView {

	@IBOutlet weak var label: UILabel?
	@IBOutlet weak var button: UIButton?


	override func updateWithCellItem(cellItem: WorktableCellItem) {
		super.updateWithCellItem(cellItem)
		if let cellItem = cellItem as? AutolayoutCellItem {
			label?.text = cellItem.labelText
			button?.setTitle(cellItem.buttonText, forState: .Normal)
		}
	}


	// TODO: Autlayout cell break if layoutSubvies it is called again here... come on
	// maybe layout can be skipped if height is automatic?
	override func willDisplayWithTable(tableView: UITableView) {}


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
