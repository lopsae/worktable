import UIKit


/**
* Base implementation of the WorktableCellItem protocol. Provides default
* values, basic functionality, and empty method implementations so that
* extending classes can implement only the functionality they need.
*
* As it is this cellItem will create a UITableViewCell cellView with the default
* height and no content.
*/
public class BaseCellItem: WorktableCellItem {

	private(set)
	public var cellViewSource: Any = UITableViewCell.self

	private(set)
	public var cellEstimatedHeight: CGFloat = UITableViewAutomaticDimension


	init() {
		// Default values
	}


	// TODO: docs about this being usefull for autolayout views
	init(viewSource: Any) {
		cellViewSource = viewSource
	}


	init(viewSource: Any, estimatedHeight:CGFloat) {
		cellViewSource = viewSource
		cellEstimatedHeight = estimatedHeight
	}

}

