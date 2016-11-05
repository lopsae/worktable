import UIKit


class DefaultCellView: BaseCellView {

	override func updateCell(with cellItem: WorktableCellItem) {
		super.updateCell(with: cellItem)
		guard let cellItem = cellItem as? DefaultCellItem else {
			return
		}

		textLabel?.text = cellItem.text
	}


	override func cellHighlighted(with cellItem: WorktableCellItem) {
		super.cellHighlighted(with: cellItem)
		updateCell(with: cellItem)

		textLabel?.text?.append(" [highlighted]")
	}


	override func cellUnhighlighted(with cellItem: WorktableCellItem) {
		super.cellUnhighlighted(with: cellItem)
		updateCell(with: cellItem)
	}

}

