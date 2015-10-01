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
		self.size.width = newWidth
	}


	mutating func set(height newHeight: CGFloat) {
		self.size.height = newHeight
	}


	mutating func set(width newWidth: CGFloat, height newHeight: CGFloat) {
		self.size.width = newWidth
		self.size.height = newHeight
	}


	mutating func set(x newX: CGFloat) {
		self.origin.x = newX
	}


	mutating func set(y newY: CGFloat) {
		self.origin.y = newY
	}


	mutating func set(x newX: CGFloat, y newY: CGFloat) {
		self.origin.x = newX
		self.origin.y = newY
	}


	mutating func set(
		x newX: CGFloat,
		y newY: CGFloat,
		width newWidth: CGFloat,
		height newHeight: CGFloat
	) {
		self.origin.x = newX
		self.origin.y = newY
		self.size.width = newWidth
		self.size.height = newHeight
	}


	mutating func add(width addWidth: CGFloat) {
		self.size.width += addWidth
	}


	mutating func add(height addHeight: CGFloat) {
		self.size.height += addHeight
	}


	mutating func add(width addWidth: CGFloat, height addHeight: CGFloat) {
		self.size.width += addWidth
		self.size.height += addHeight
	}


	mutating func add(x addX: CGFloat) {
		self.origin.x += addX
	}


	mutating func add(y addY: CGFloat) {
		self.origin.y += addY
	}


	mutating func add(x addX: CGFloat, y addY: CGFloat) {
		self.origin.x += addX
		self.origin.y += addY
	}


	mutating func add(
		x addX: CGFloat,
		y addY: CGFloat,
		width addWidth: CGFloat,
		height addHeight: CGFloat
	) {
		self.origin.x += addX
		self.origin.y += addY
		self.size.width += addWidth
		self.size.height += addHeight
	}


}