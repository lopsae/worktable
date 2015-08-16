import UIKit


public protocol WorktableCellItem {

    var viewClass: AnyClass? { get }
    var viewNib: UINib? { get }
    var reuseIdentifier: String { get }
    
    
    // TODO this should be moved to a delegate?
    // func cellSelectedWithView(cellview: WorktableCellView)

}