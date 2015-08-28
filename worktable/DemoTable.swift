import UIKit


class DemoTable: WorktableViewController {

	init () {
		super.init(style: .Grouped)
		navigationItem.title = "Demo table"
	}


	override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}


	required init!(coder: NSCoder!) {
		super.init(coder: coder)
	}


	override func viewDidLoad() {
		super.viewDidLoad()

		addNewSection()

		pushCellItem(WorktableCellItemBase("cell 1"))
		pushCellItem(DoubleTextCellItem(LoremIpsum.string(3), buttonText: "button one"))
		pushCellItem(VariableHeightCellItem(80))

		addNewSection()
		pushCellItem(WorktableCellItemBase("cell 2"))
		pushCellItem(DoubleTextCellItem(LoremIpsum.string(12), buttonText: "button two"))
		pushCellItem(WorktableCellItemBase("cell 3"))
		pushCellItem(DoubleTextCellItem(LoremIpsum.string(20), buttonText: "button three"))
	}


}
