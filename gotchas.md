Gotchas
=======
Notes about gotchas and side effects in using ios table views.
Also rationale for aproaches taken and modifications done, in order to remember and not do them again.



Different behaviors during creation and scrolling
-------------------------------------------------
The table view creates cells in two different moments: during intialization (or first display) and during scrolling.

During initialization (or first display or table reload) estimated height of all cells is requested. Visible cellsViews are created and actual height for those is requested. Depending on the values provided for estimated and actual height, the height request can happen again.

During scrolling, as new cells become visible, cellViews for those are created and actual height is requested only once.



During initializaton if estimated and actual height match, actual height is requested again; but not during scroll
---------------------------------------------------------------------------
During initialization if estimated and actual height match, actual height is requested again. The following happens in order:

- CellView is created or dequeued
- Actual height is requested for the first time; cellView **is not available** through `tableView.cellForRowAtIndexPath`
- The `willDisplayCell` delegate method is called
- Actual height is requested again, in some conditions twice; cellView **is available** through `tableView.cellForRowAtIndexPath`
- CellView is displayed with the last height provided

During scroll cell creation height is requested only once. The following happens in order:
- CellView is created or dequeued
- Actual height is requested: cellView **is not available** through `tableView.cellForRowAtIndexPath`
- The `willDisplayCell` delegate method is called
- CellView is displayed with the last height provided



Neither cellView, nor correct frame size, is unavailable during height request
---------------------------------------------------------------------------
The following events always happen in order both during table initialization and during scrolling:
- CellView is created or dequeued; cellView frame is either the last one set when dequeued, or it is created with the default (not the actual) width, and the estimated height
- Actual height is requested; cellView **is not available** through `tableView.cellForRowAtIndexPath`
- The `willDisplayCell` delegate method is called; cellView frame is already updated to the actual width and the actual height
- Afterwards the cellView **is available** through `tableView.cellForRowAtIndexPath`

This bears no issue with cells using automatic layout, since all the resizing is handled internally.

Dynamic cellViews—cells that may change their size during `layoutSubviews`—have no chance to adjust their height properly using the provided infraestructure. Either:
- During creation they have to provide a specific combination of estimated and actual height to trigger post-`willDisplayCell` height requests
- Or during scrolling there is no height request in which cellView is available and the correct frame is set



Estimated height is requested several times during table creation
-----------------------------------------------------------------
During initialization estimated height is requested 5 times for each cell.

Estimated height do not happen when scrolling, at least when there is no change in the cells displayed.

When reloading the table estimated height is requested only once per cell.



Refresh control does not trigger end animations if content is scrolled
----------------------------------------------------------------------
After the refreshControl has been activated and the content has been scrolled to the top. If the user scrolls the content so that it covers partially or completely the refreshControl (that is, the content is above the inset), then calling `refreshControl.endRefreshin()` will not trigger a scroll in the view.

When the scroll is properly at the top when `endRefreshing()` is called, then the scroll animations to hide the `refreshControll` happen automatically.



Scrolling by code from anywhere except the top, after activating a refreshControl, prevents automatic scroll after refreshing
---------------------------------------------------------------------------
If a refresh control is activated by code te view will not scroll and needs to be activated by code too.

If at the moment of triggering the scroll the content is at the top, everything works normally.

If at the moment of triggering the scroll the content was over the inset, and the content remains at the top position during the refreshing, after calling `refreshControl.endRefreshing()` the closing animations will not happen.



Broken approaches
=================
Approaches tried and removed since they broke somewhere else.



Returning matching estimated and actual height to allow later height adjustment does not work
---------------------------------------------------------------------------
Providing matching estimated and actual height during the table initialization causes further calls to `heightForCell` to happen after the `willDisplayCell` delegate method is called.

At the `willDisplayCell` method call the frame correct frame size is set; the method was used to call the `layoutSubviews` method in the cellViews, allowing them to update their size and report the correct size when further height requests happen.

This approach breaks when scrolling. In this case there is no further calls to `heightForCell` to update the size.

Size can be updated through other means, like `beginUpdates`-`endUpdates`, but this triggers animations.



Autolayout cellViews broken when first actual height was estimated height
-------------------------------------------------------------------------
Estimated height is provided by the cellItem, and actual height is provided by the cellView when its available.

During table initialization, since the cellView is not available during the first `heightForCell` call, the estimaged height was returned instead. Returning matching estimated and actual height caused the height to be requested later again when the cell would be available with the correct height.

This approach failed during scrolling: `heightForCell` is called only once and the cellView is not available.

If a cellItem for an autolayout cellView provided a specific height (not automaticDimention) this would be returned again during the `heightForCell` call. This being the only height requests causes the cellView to be displayed with a fixed height.


