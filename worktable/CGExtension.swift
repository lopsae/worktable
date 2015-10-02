import UIKit


extension CGRect {

	init(originOf originRect: CGRect) {
		self = CGRect(origin: originRect.origin, size: CGSizeZero)
	}


	init(sizeOf sizeRect: CGRect) {
		self = CGRect(origin: CGPointZero, size: sizeRect.size)
	}


	init(originOf originRect: CGRect, sizeOf sizeRect: CGRect) {
		self = CGRect(origin: originRect.origin, size: sizeRect.size)
	}

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


	var w: CGFloat {
		get {
			return size.width
		}

		mutating set {
			size.width = newValue
		}
	}


	var h: CGFloat {
		get {
			return size.height
		}

		mutating set {
			size.height = newValue
		}
	}


	// The margin methods push the side of the rect by its side name:
	//
	// origin    y side
	//     -> +----------·
	//        |          |
	//   x    |          | w
	//   side |          | side
	//        |          |
	//        ·----------·
	//           h side
	//
	// x and y values increase
	// w and h values decrease

	mutating func pushMarginX(push: CGFloat) {
		x += push
		if (w > push) {
			w -= push
		} else {
			w = 0
		}
	}


	mutating func pushMarginY(push: CGFloat) {
		y += push
		if (h > push) {
			h -= push
		} else {
			h = 0
		}
	}


	mutating func pushMarginW(push: CGFloat) {
		if (w > push) {
			w -= push
		} else {
			w = 0
			x += w - push
		}
	}


	mutating func pushMarginH(push: CGFloat) {
		if (h > push) {
			h -= push
		} else {
			h = 0
			y += h - push
		}
	}


	mutating func centerWidthInto(centerRect: CGRect) {
		x = centerRect.x + (centerRect.w - w) / 2
	}


	mutating func centerHeightInto(centerRect: CGRect) {
		y = centerRect.y + (centerRect.h - h) / 2
	}


	mutating func centerInto(centerRect: CGRect) {
		centerWidthInto(centerRect)
		centerHeightInto(centerRect)
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