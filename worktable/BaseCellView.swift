import UIKit



/// Base implementation of the WorktableCellView protocol. Provides default
/// values, basic functionality, and empty method implementations to allow
/// extending classes to only implement the functionality they need.
///
/// The basic functionality implemented is:
/// - Empty `UITableViewCell` with default height and no content.
/// - When cell is selected or deselected, the updateCell(with:) method is called.
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


	/// Called after `self` is initialized.
	///
	/// Convenience method that allows extending classes to only override
	/// `postInit` instead of all the required `init` methods.
	open func postInit() {
		// To override
	}


	open func updateCellHeight(_ height: CGFloat) {
		cellHeight = height
		// TODO: trigger update in table view if not in creation or scroll
	}


	open func updateCell(with cellItem: WorktableCellItem) {
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


	open func cellHighlighted(with cellItem: WorktableCellItem) {
		// To override
	}


	open func cellUnhighlighted(with cellItem: WorktableCellItem) {
		// To override
	}


	open func cellSelected(with cellItem: WorktableCellItem) {
		updateCell(with: cellItem)
	}


	open func cellDeselected(with cellItem: WorktableCellItem) {
		updateCell(with: cellItem)
	}


}
