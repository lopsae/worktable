import UIKit


public protocol WorktableCellItem {

	/// Source of the cell-view that will be created for `self`.
	var viewSource: WorktableCellViewSource { get }


	/// Estimated height of the cell-view that will be created for `self`.
	///
	/// This value must be the same through the lifetime of a cell-item. While
	/// a cell-item is contained by a table its estimated height should not
	/// change.
	///
	/// This value is used for both the estimated height and the actual height
	/// while the cell-view is created. If different values are provided between
	/// calls the table may not adjust properly to changes in the height
	/// provided by the cell-view.
	var estimatedHeight: CGFloat { get }


	func cellSelected(with cellView: WorktableCellView)


	func cellDeselected(with cellView: WorktableCellView)

}


/// Defines the means in which a cell-view is instantiated.
public enum WorktableCellViewSource {

	/// Nib name and bundle identifier of a xib file that contains an
	/// `UITableViewCell` instance.
	case nib(name:String, bundleId: String?)

	/// Type to instantiate a `UITableViewCell` instance.
	///
	/// - Note: The contained type must be a subtype of `UITableViewCell.Type`,
	///   otherwise a `preconditionFailure` will ocurr when the cell-item is
	///   added to a `WorktableViewController` instance.
	case type(AnyClass)
}
