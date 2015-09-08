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

		pushCellItem(DefaultCellItem("cell 1"))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(3), buttonText: "button one"))
		pushCellItem(VariableHeightCellItem(initialHeight: 80))

		addNewSection()
		pushCellItem(DefaultCellItem("cell 2"))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(12), buttonText: "button two"))
		pushCellItem(DefaultCellItem("cell 3"))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(20), buttonText: "button three"))

		pushCellItem(AutolayoutCellItem(LoremIpsum.string(20), buttonText: "button four"))
		pushCellItem(VariableHeightCellItem(initialHeight: 80))
		pushCellItem(DefaultCellItem("cell 4"))
	}


}
