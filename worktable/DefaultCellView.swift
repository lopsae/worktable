import UIKit


class DefaultCellView: BaseCellView {

	override func updateCell(with cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? DefaultCellItem {
			textLabel?.text = cellItem.text
		}
	}

}

