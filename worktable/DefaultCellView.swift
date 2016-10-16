import UIKit


class DefaultCellView: BaseCellView {

	override func updateWithCellItem(_ cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? DefaultCellItem {
			textLabel?.text = cellItem.text
		}
	}

}

