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
			let distance = pow(origin.x - center.x, 2) +
				pow(origin.y - center.y , 2)
			return sqrt(distance)
		}
	}


	var x: CGFloat {
		get {
			return origin.x
		}

		mutating set {
			origin.x = newValue
		}
	}


	var y: CGFloat {
		get {
			return origin.y
		}

		mutating set {
			origin.y = newValue
		}
	}


	mutating func set(width newWidth: CGFloat) {
		size.width = newWidth
	}


	mutating func set(height newHeight: CGFloat) {
		size.height = newHeight
	}


	mutating func set(width newWidth: CGFloat, height newHeight: CGFloat) {
		size.width = newWidth
		size.height = newHeight
	}


	mutating func set(x newX: CGFloat) {
		origin.x = newX
	}


	mutating func set(y newY: CGFloat) {
		origin.y = newY
	}


	mutating func set(x newX: CGFloat, y newY: CGFloat) {
		origin.x = newX
		origin.y = newY
	}


	mutating func set(
		x newX: CGFloat,
		y newY: CGFloat,
		width newWidth: CGFloat,
		height newHeight: CGFloat
	) {
		origin.x = newX
		origin.y = newY
		size.width = newWidth
		size.height = newHeight
	}


	mutating func add(width addWidth: CGFloat) {
		size.width += addWidth
	}


	mutating func add(height addHeight: CGFloat) {
		size.height += addHeight
	}


	mutating func add(width addWidth: CGFloat, height addHeight: CGFloat) {
		size.width += addWidth
		size.height += addHeight
	}


	mutating func add(x addX: CGFloat) {
		origin.x += addX
	}


	mutating func add(y addY: CGFloat) {
		origin.y += addY
	}


	mutating func add(x addX: CGFloat, y addY: CGFloat) {
		origin.x += addX
		origin.y += addY
	}


	mutating func add(
		x addX: CGFloat,
		y addY: CGFloat,
		width addWidth: CGFloat,
		height addHeight: CGFloat
	) {
		origin.x += addX
		origin.y += addY
		size.width += addWidth
		size.height += addHeight
	}


}