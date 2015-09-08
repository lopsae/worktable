import UIKit


class DefaultCellItem : BaseCellItem {

	var text: String


	init(_ initialText: String) {
		text = initialText
		super.init(viewSource: DefaultCellView.self)
	}

}
