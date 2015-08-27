import UIKit


class WorktableCellItemBase : WorktableCellItem {

	let REUSE_IDENTIFIER = "WorktableCellItemBase"

	var viewClass: AnyClass?
	var viewNib: UINib?
	var reuseIdentifier: String

	var text: String


	init(_ initialText: String) {
		viewClass = WorktableCellViewBase.self
		reuseIdentifier = REUSE_IDENTIFIER

		text = initialText
	}

}
