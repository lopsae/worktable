import UIKit


public protocol WorktableCellView {

    var isSelectable: Bool { get }
    var height: Int { get }
    
    // TODO to be moved to a delegate protocol
    func updateWithItem(cellItem: WorktableCellItem)
    
    func willDisplayWithTable(tableView: UITableView)
    
    func willEndDisplayWithTable(tableView: UITableView)
    
    func cellSelectedWithItem(cellItem: WorktableCellItem)
    
}