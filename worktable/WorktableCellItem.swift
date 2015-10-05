import UIKit


public protocol WorktableCellItem {

	/// Class or nibName of the cellView for this cellItem. This object is used
	/// by the WorktableViewController to register the Type or nib that will be
	/// used to create cellViews for the instance.
	///
	/// If viewSource is a String object it will be interpreted as the name of
	/// the nib to use in the default bundle.
	///
	/// If viewSource is a Type it must extend from `UITableViewCell.Type`
	///
	/// - Note: Any unexpected value will cause a `preconditionFailure` when the
	///   cellItem is added to a `WorktableViewController` instance.
	var cellViewSource: Any { get }


	/// Estimated height of the cellView that will be created for this cellItem.
	///
	/// It is important that the value returned is the same through the lifetime
	/// of the cellItem in a table. That is, while a cellItem is contained by a
	/// table its estimated height should not change.
	///
	/// This value is used for both the estimated height and the actual height
	/// while the cellView is created. If different values are provided between
	/// calls the table may not adjust properly to changes in the height
	/// provided by the cellView.
	var cellEstimatedHeight: CGFloat { get }


	func cellSelectedWithView(cellview: WorktableCellView?)


	func cellDeselectedWithView(cellview: WorktableCellView?)

}