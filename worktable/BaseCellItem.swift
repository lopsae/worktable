import UIKit



/// Base implementation of the WorktableCellItem protocol. Provides default
/// values, basic functionality, and empty method implementations to allow
/// extending classes to only implement the functionality as needed.
///
/// By default an instance of this class will create a `UITableViewCell`
/// cellView with with an estimated height of `UITableViewAutomaticDimension`
/// and no content.
public class BaseCellItem: WorktableCellItem {

	private(set)
	public var cellViewSource: Any = UITableViewCell.self

	private(set)
	public var cellEstimatedHeight: CGFloat = UITableViewAutomaticDimension


	/// Creates an instance with the default values.
	init() {
		// Default values
	}


	/// Creates an instance with the given `viewSource` instead of the default.
	///
	/// - Parameter viewSource: Any type that extends from
	///   `UITableViewCell.Type` or a `String` with the name of the nib to use.
	init(viewSource: Any) {
		cellViewSource = viewSource
	}


	/// Creates an instance with the given `viewSource` and `estimatedHeight`
	/// instead of the defaults.
	///
	/// - Parameter viewSource: Any type that extends from
	///   `UITableViewCell.Type` or a `String` with the name of the nib to use.
	///
	/// - Parameter estimatedHeight: The estimated height of the cell.
	///   default.
	init(viewSource: Any, estimatedHeight:CGFloat) {
		cellViewSource = viewSource
		cellEstimatedHeight = estimatedHeight
	}


	public func cellSelectedWithView(cellview: WorktableCellView?) {
		// To override
	}

}

