import UIKit


/// Example celItem for a cell that uses the `UITableCellView` as provided.
class DefaultCellItem : BaseCellItem {

	var text: String


	init(_ initialText: String) {
		text = initialText
		super.init(viewSource: DefaultCellView.self)
	}

}
