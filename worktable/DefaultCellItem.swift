import UIKit


/// Example cell-item for a cell that uses the `UITableCellView` as provided.
///
/// When the cell is selected the contained text is updated accordingly.
class DefaultCellItem : BaseCellItem {

	let baseText: String
	var text: String


	init(_ initialText: String) {
		baseText = initialText
		text = initialText
		super.init(type: DefaultCellView.self)
	}


	override func cellSelected(with _: WorktableCellView) {
		text =  "\(baseText) [selected]"
	}


	override func cellDeselected(with cellView: WorktableCellView) {
		text = baseText
	}

}
