import UIKit


class DemoTable: WorktableViewController {

	init () {
		super.init(style: .Grouped)
		navigationItem.title = "Demo table"
	}


	override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}


	required init!(coder aDecoder: NSCoder!) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad() {
		super.viewDidLoad()

		addNewSection()

		pushCellItem(WorktableCellItemBase("cell 1"))
		pushCellItem(WorktableCellItemBase("cell 2"))

		addNewSection()

		pushCellItem(WorktableCellItemBase("celda 1"))
		pushCellItem(WorktableCellItemBase("celda 2"))
		pushCellItem(WorktableCellItemBase("celda 3"))
	}

}
