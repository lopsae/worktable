import UIKit


/**
Base implementation of the WorktableCellView protocol. Provides default values,
basic functionality, and empty method implementations to allow extending classes
to only implement the functionality they need.

As it is this cellView will create a UITableViewCell cellView with the default
height and no content.
*/
open class BaseCellView: UITableViewCell, WorktableCellView {

	private(set)
	open var cellHeight = UITableViewAutomaticDimension


	private(set)
	open var isDisplayed = false


	/// Convenience property to enable and disable the default hightlight and
	/// selection visuals of `UITableViewCell`.
	///
	/// Regardless of the value of this property the cellView will still receive
	/// calls for highlight and selection events.
	open var isSelectionVisible: Bool {
		get {
			return selectionStyle != .none
		}

		set {
			selectionStyle = newValue ? .default : .none
		}
	}


	init?(
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
		self.init(height: nil, style: style, reuseIdentifier: reuseIdentifier, coder: nil)!
	}

	required convenience public init?(coder: NSCoder) {
		self.init(height: nil, style: nil, reuseIdentifier: nil, coder: coder)
	}


	convenience public init(height: CGFloat) {
		self.init(height: height, style: nil, reuseIdentifier: nil, coder: nil)!
	}


	open func postInit() {
		// To override
	}


	open func updateCellHeight(_ height: CGFloat) {
		cellHeight = height
		// TODO: trigger update in table view if not in creation or scroll
	}


	open func updateWithCellItem(_ cellItem: WorktableCellItem) {
		// To override
	}


	open func willReportCellHeight(_ controller: WorktableViewController) {
			layoutIfNeeded()
	}


	open func willDisplayCell(_ controller: WorktableViewController) {
		isDisplayed = true
	}


	open func didEndDisplayingCell(_ controller: WorktableViewController) {
		isDisplayed = false
	}


	open func cellHightlightedWithItem(_ cellItem: WorktableCellItem) {
		// To override
	}


	open func cellUnhightlightedWithItem(_ cellItem: WorktableCellItem) {
		// To override
	}


	open func cellSelectedWithItem(_ cellItem: WorktableCellItem) {
		updateWithCellItem(cellItem)
	}


	open func cellDeselectedWithItem(_ cellItem: WorktableCellItem) {
		// To override
	}


}
