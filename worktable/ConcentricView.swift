import UIKit


/**
 * UIView that draws a pattern inside all its drawable area and a border around
 * its frame. Good for testing scrolling and layouts.
 */
class ConcentricView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.lightGray
	}


	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}


	override func draw(_ rect: CGRect) {
		// Concentric circles
		let largestRadius = bounds.distanceCenterToCorner
		let circlesPath = UIBezierPath()

		var currentRadius:CGFloat = 10
		while currentRadius < largestRadius {
			var startPoint = bounds.center
			startPoint.x += currentRadius
			circlesPath.move(to: startPoint)
			circlesPath.addArc(withCenter: bounds.center,
			                   radius: currentRadius,
			                   startAngle: 0,
			                   endAngle: CGFloat(M_PI)*2,
			                   clockwise: true
			)

			currentRadius += 30
		}

		circlesPath.lineWidth = 10
		UIColor.darkGray.setStroke()
		circlesPath.stroke()

		// View border
		let borderPath = UIBezierPath(rect: bounds)
		borderPath.lineWidth = 10
		UIColor.red.setStroke()
		borderPath.stroke()

		// Frame label
		// PlaceBounds is the rectangle in which the label will be centered
		var labelPlaceBounds = bounds
		labelPlaceBounds.pushMarginX(10)

		let labelFont = UIFont(name: "HelveticaNeue", size: 14)
		let labelForeColor = UIColor.red

		var labelAttributes = [String: AnyObject]()
		labelAttributes[NSFontAttributeName] = labelFont
		labelAttributes[NSForegroundColorAttributeName] = labelForeColor

		let label = NSAttributedString(
			string: "\(bounds.size.width),\(bounds.size.height)",
			attributes: labelAttributes
		)

		let drawOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .truncatesLastVisibleLine]

		// Draw bounds is the rectangle that the drawed text will ocupy exactly
		let labelDrawBounds = label.boundingRect(with: labelPlaceBounds.size,
			options: drawOptions,
			context: nil
		)

		var centeredRect = CGRect(sizeOf: labelDrawBounds)
		centeredRect.x = labelPlaceBounds.x
		centeredRect.centerHeightInto(labelPlaceBounds)

		label.draw(with: centeredRect, options: drawOptions, context: nil)
	}

}
