import UIKit


class WorktableCellItemBase : BaseCellItem {

	var text: String


	init(_ initialText: String) {
		text = initialText
		super.init(viewSource: WorktableCellViewBase.self)
	}

}
