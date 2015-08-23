import UIKit


class DemoTable: WorktableViewController {

	init () {
		super.init(style: .Grouped)
		navigationItem.title = "Demo table"
		tableView.estimatedRowHeight = 44
		tableView.rowHeight = UITableViewAutomaticDimension
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
		pushCellItem(DoubleTextCellItem("one label", buttonText: "one button"))

		addNewSection()

		pushCellItem(WorktableCellItemBase("celda 1"))
		pushCellItem(DoubleTextCellItem("two label lorem ipsum dolor sit amet lorem ipsum dolor sit amet", buttonText: "two button"))
		pushCellItem(WorktableCellItemBase("celda 3"))
		pushCellItem(DoubleTextCellItem("three label lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet", buttonText: "three button"))
	}


}
