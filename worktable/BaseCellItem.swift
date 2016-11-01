import UIKit



/// Base implementation of the WorktableCellItem protocol. Provides default
/// values, basic functionality, and empty method implementations to allow
/// extending classes to only implement functionality as needed.
///
/// By default an instance of this class will create a `UITableViewCell`
/// cellView with with an estimated height of `UITableViewAutomaticDimension`
/// and no content.
open class BaseCellItem: WorktableCellItem {

	private(set)
	open var viewSource: WorktableCellViewSource = .type(UITableViewCell.self)

	private(set)
	open var cellEstimatedHeight: CGFloat = UITableViewAutomaticDimension


	/// Creates an instance with the default values.
	init() {
		// Default values
	}


	/// Creates an instance with the given `nibName` and `bundle`.
	///
	/// - Parameter nibName: The name of the nib used to create the view 
	///	  for this cell item.
	/// - Parameter bundleId: Bundle identifier for the nib, defaults to `nil`.
	/// - Parameter estimatedHeight: Estimated height for the cell.
	init(nibName: String, bundleId: String? = nil, estimatedHeight: CGFloat? = nil) {
		viewSource = .nib(nibName, bundleId: bundleId)
		cellEstimatedHeight = estimatedHeight ?? UITableViewAutomaticDimension
	}


	/// Creates an instance with the given `type`.
	///
	/// - Parameter type: The type used to initialize the view for this cell.
	///   Must be a subtype of `UITableViewCell.Type`.
	/// - Parameter estimatedHeight: Estimated height for the cell.
	init(type: AnyClass, estimatedHeight: CGFloat? = nil) {
		viewSource = .type(type)
		cellEstimatedHeight = estimatedHeight ?? UITableViewAutomaticDimension
	}


	open func cellSelectedWithView(_ cellview: WorktableCellView?) {
		// To override
	}


	open func cellDeselectedWithView(_ cellview: WorktableCellView?) {
		// To override
	}

}

