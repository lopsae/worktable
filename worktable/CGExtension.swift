import UIKit


extension CGRect {

	/**
	Returns a point at the center of the rectangle.
	*/
	var center: CGPoint {
		get {
			return CGPoint(x: midX, y: midY)
		}
	}


	/**
	Returns the distance from the center of the rectangle to of its corners.
	*/
	var distanceCenterToCorner: CGFloat {
		get {
			var distance = pow(origin.x - center.x, 2) +
				pow(origin.y - center.y , 2)
			return sqrt(distance)
		}
	}

}