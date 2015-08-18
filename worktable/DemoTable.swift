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
        
        pushCellItem(WorktableCellItemBase())
        pushCellItem(WorktableCellItemBase())
        
        addNewSection()
        
        pushCellItem(WorktableCellItemBase())
        pushCellItem(WorktableCellItemBase())
        pushCellItem(WorktableCellItemBase())
        
    }
    
}