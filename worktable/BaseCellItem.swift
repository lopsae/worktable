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
	public var viewSource: Any = UITableViewCell.self

	private(set)
	public var estimatedHeight: CGFloat = UITableViewAutomaticDimension


	init() {
		// Default values
	}


	// TODO docs about this being usefull for autolayout views
	init(viewSource: Any) {
		self.viewSource = viewSource
	}


	init(viewSource: Any, estimatedHeight:CGFloat) {
		self.viewSource = viewSource
		self.estimatedHeight = estimatedHeight
	}



}
