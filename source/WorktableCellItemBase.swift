import UIKit


class WorktableCellItemBase : WorktableCellItem {

    let REUSE_IDENTIFIER = "worktableCellDemo"
    
    var viewClass: AnyClass?
    var viewNib: UINib?
    var reuseIdentifier: String
    
    
    init() {
        viewClass = WorktableCellViewBase.self
        reuseIdentifier = REUSE_IDENTIFIER
    }
    
}