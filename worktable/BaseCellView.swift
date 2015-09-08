import UIKit


/**
Base implementation of the WorktableCellView protocol. Provides default values,
basic functionality, and empty method implementations to allow extending classes
to only implement the functionality they need.

As it is this cellView will create a UITableViewCell cellView with the default
height and no content.
*/
public class BaseCellView: UITableViewCell, WorktableCellView {

	private(set)
	public var cellHeight = UITableViewAutomaticDimension


	init(
		height: CGFloat?,
		style: UITableViewCellStyle?,
		reuseIdentifier: String?,
		coder: NSCoder?
	) {
		if let height = height {
			cellHeight = height
		}

		if coder != nil {
			super.init(coder: coder!)
		} else if style != nil {
			super.init(style: style!, reuseIdentifier: reuseIdentifier)
		} else {
			super.init()
		}
		postInit()
	}


	override convenience init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		self.init(height: nil, style: style, reuseIdentifier: reuseIdentifier, coder: nil)
	}

	required convenience public init(coder: NSCoder) {
		self.init(height: nil, style: nil, reuseIdentifier: nil, coder: coder)
	}


	convenience public init(height: CGFloat) {
		self.init(height: height, style: nil, reuseIdentifier: nil, coder: nil)
	}


	public func postInit() {
		// To override
	}


	public func updateCellHeight(height: CGFloat) {
		cellHeight = height
		// TODO: trigger update in table view
	}


	public func updateWithCellItem(cellItem: WorktableCellItem) {
		// To override
	}


	public func willDisplayWithTable(tableView: UITableView) {
		// this allows cells that handle their own layout to layout themselves
		// and update their height. At the time of this call the cellView will
		// have a frame with the correct width and as height that returned by
		// the cellItem.estimatedHeight
		layoutIfNeeded()
	}

	

}
