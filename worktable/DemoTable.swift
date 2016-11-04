import UIKit


class DemoTable: WorktableViewController {

	init () {
		super.init(style: .grouped)
	}


	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}


	required init!(coder: NSCoder) {
		super.init(coder: coder)
	}


	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.title = "Demo table"

		// TODO: move refresh to a action sheet?
		//		let reloadButton = UIBarButtonItem(
		//			title: "Refresh",
		//			style: .Plain,
		//			target: self,
		//			action: "refreshTable"
		//		)

		addRefreshIndicator()

		refreshDidEnd = {_ in
			self.removeRefreshIndicator()
		}

		pushCellItem(DefaultCellItem("cell 1"))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(3), buttonText: "button one"))
		pushCellItem(VariableHeightCellItem(initialHeight: 80))

		addNewSection()
		pushCellItem(DefaultCellItem("cell 2"))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(12), buttonText: "button two"))
		pushCellItem(DefaultCellItem("cell 3"))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(20), buttonText: "button three"))

		pushCellItem(VariableHeightCellItem(initialHeight: 120))
		pushCellItem(VariableHeightCellItem(initialHeight: 80))
		pushCellItem(AutolayoutCellItem(LoremIpsum.string(20), buttonText: "button four"))
		pushCellItem(VariableHeightCellItem(initialHeight: 80))
		pushCellItem(DefaultCellItem("cell 4"))
	}


	func reloadTable() {
		tableView.reloadData()
	}


	func refreshTable() {
		beginRefresh()
	}

	// TODO: move this actions into an ActionSheet
	func removeRefreshIndicator() {
		refreshEnabled = false

		let removeRefreshControlButton = UIBarButtonItem(
			title: "Add Ind",
			style: .plain,
			target: self,
			action: #selector(DemoTable.addRefreshIndicator))

		navigationItem.rightBarButtonItem = removeRefreshControlButton
	}

	// TODO: move this actions into an ActionSheet
	func addRefreshIndicator() {
		refreshEnabled = true

		let removeRefreshControlButton = UIBarButtonItem(
			title: "Remove Ind",
			style: .plain,
			target: self,
			action: #selector(DemoTable.removeRefreshIndicator))

		navigationItem.rightBarButtonItem = removeRefreshControlButton
	}

}
