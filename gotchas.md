Gotchas
=======
Notes about gotchas and side effects in using ios table views.
Also reasons why some approaches or modifications where taken, in order to remember and not do them again.


Height is not requested again if its different from estimated height
--------------------------------------------------------------------
During initialization if estimated and actual height are different, no more calls happen. If they are the same, height is rerequested, which allows height to be adjusted.

However during scroll cell creation height is requested only once.
TODO: check if the frame is correct in this case, assumption is that not and this is the cause of many problems



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
