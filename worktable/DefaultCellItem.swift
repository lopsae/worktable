import UIKit


/// Example celItem for a cell that uses the `UITableCellView` as provided.
class DefaultCellItem : BaseCellItem {

	var baseText: String
	var text: String


	init(_ initialText: String) {
		baseText = initialText
		text = initialText
		super.init(type: DefaultCellView.self)
	}


	override func cellSelectedWithView(_ cellview: WorktableCellView?) {
		text =  "\(baseText) selected"
	}

}
