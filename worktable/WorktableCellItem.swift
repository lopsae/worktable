import UIKit


public protocol WorktableCellItem {

	/**
	* Class or nibName of the cellView for this cellItem. This object is used
	* by the WorktableViewController to register the class or nib that will be
	* used to create cellViews for cellItems of this class.
	*
	* If viewSource is a String object it will be interpreted as the name of the
	* nib to use in the default bundle.
	*
	* If viewSource is a Class type it must be a class extending
	* UITableViewCell.
	*
	* Any other object or value will cause a assertion failure when the cellItem
	* is added to a WorktableViewController instance.
	*/
	var viewSource: Any { get }

	/**
	* Estimated height of the cellView that will be created for this cellItem.
	* While this value can be calculated it is important that the same value is
	* returned consistently. This value is used for both the estimated height
	* and the actual height while the cellView is being created. If different
	* values are provided the table may not adjust properly to any further
	* height changes that happen on the cellView.
	*/
	var estimatedHeight: CGFloat { get }
    
    
    // TODO this should be moved to a delegate?
    // func cellSelectedWithView(cellview: WorktableCellView)

}