import UIKit


class DefaultCellView: BaseCellView {

	override func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? DefaultCellItem {
			textLabel?.text = cellItem.text
		}
	}

}

