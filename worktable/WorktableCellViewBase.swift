import UIKit


class WorktableCellViewBase: BaseCellView {

	override func updateWithCellItem(cellItem: WorktableCellItem) {
		if let cellItem = cellItem as? WorktableCellItemBase {
			textLabel?.text = cellItem.text
		}
	}

}

