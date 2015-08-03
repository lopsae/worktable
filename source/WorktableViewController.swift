import UIKit


class WorktableViewController: UITableViewController {
    
    let REUSE_IDENTIFIER = "worktableCell"
    
    private var sections = [String]()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: REUSE_IDENTIFIER)
    }
    
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCellWithIdentifier(REUSE_IDENTIFIER) as! UITableViewCell
        cellView.textLabel?.text = "wortable cell \(indexPath.row)"
        return cellView
    }
    
    
    
    
    
}

