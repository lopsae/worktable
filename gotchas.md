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
During initialization if estimated and actual height match, actual height is requested again. The following happen in order:

- CellView is created or dequeued
- Actual height is requested for the first time; cellView **is not available** through `tableView.cellForRowAtIndexPath`
- The `willDisplayCell` delegate method is called, at this point the frame of the cell is already setup correctly with width of the table, and the height provided as actual height
- Actual height is requested again, in some conditions twice; cellView **is available** through `tableView.cellForRowAtIndexPath`
- CellView is displayed with the last height provided

During scroll cell creation height is requested only once. The following happen in order:
- CellView is created or dequeued
- Actual height is requested: cellView **is not available** through `tableView.cellForRowAtIndexPath`
- CellView is displayed with the last height provided



CellView is unavailable during height request
---------------------------------------------
CellView creation happens always before requesting the height. CellViews are however unavailable using the `table.cellForRowAtIndexPath` method.

This is an issue for dinamically sized cellViews, which height can be known only when layout is done, and that depends on having the correct frame width already setup.



Final frame is unavailable until willDisplayCell
------------------------------------------------
During table initialization cellViews will be created and its height requested.

Even storing the cellView from its creation the frame is not set appropiately until later.

TODO: what is the size of the frame during creation? default width and aproximated height?

Single point where it has been found consistently that frame is already set correct is until `willDisplayCell` is called, when the width is already correct and the height is set to the value returned by `heightForCell`.

During startup, if same value is provided for estimated and actual height then the `willDisplayCell` is called, and height is requested again.

If actual height is different, height is not requested again.

During scrolling cellView creation height is requested once, followed by `willDisplayCell`, TODO: is frame setup correctly in this case?



Estimated height is requested repeatedly during table creation
--------------------------------------------------------------
Estimated height is requested several times when the table initializes. Even having a single cell causes the estimated height to be requested up to five times, all for the same single cell.

If you have more cells the requests increase exponentially?

TODO: Check how many requests happen as cell size increases
