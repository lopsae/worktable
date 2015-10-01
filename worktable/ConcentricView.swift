import UIKit


/**
 * UIView that draws a pattern inside all its drawable area and a border around
 * its frame. Good for testing scrolling and layouts.
 */
class ConcentricView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.lightGrayColor()
	}


	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}


	override func drawRect(rect: CGRect) {
		// Concentric circles
		let largestRadius = bounds.distanceCenterToCorner
		let circlesPath = UIBezierPath()

		for var currentRadius: CGFloat = 10; currentRadius < largestRadius; currentRadius += 30 {
			var startPoint = bounds.center
			startPoint.x += currentRadius
			circlesPath.moveToPoint(startPoint)
			circlesPath.addArcWithCenter(bounds.center,
				radius: currentRadius,
				startAngle: 0,
				endAngle: CGFloat(M_PI)*2,
				clockwise: true
			)
		}

		circlesPath.lineWidth = 10
		UIColor.darkGrayColor().setStroke()
		circlesPath.stroke()

		// View border
		let borderPath = UIBezierPath(rect: bounds)
		borderPath.lineWidth = 10
		UIColor.redColor().setStroke()
		borderPath.stroke()

		// Frame label
		var labelPlaceBounds = bounds

		labelPlaceBounds.x += 10
		labelPlaceBounds.add(width: -10)

		let labelFont = UIFont(name: "HelveticaNeue", size: 14)
		let labelForeColor = UIColor.redColor()

		var labelAttributes = [String: AnyObject]()
		labelAttributes[NSFontAttributeName] = labelFont
		labelAttributes[NSForegroundColorAttributeName] = labelForeColor

		let label = NSAttributedString(
			string: "\(bounds.size.width),\(bounds.size.height)",
			attributes: labelAttributes
		)

		let drawOptions: NSStringDrawingOptions = [.UsesLineFragmentOrigin, .TruncatesLastVisibleLine]

		let labelDrawBounds = label.boundingRectWithSize(labelPlaceBounds.size,
			options: drawOptions,
			context: nil
		)

		// TODO: CGFloat extension for ceil/floor methods?
		var centeredRect = CGRect()
		centeredRect.x = labelPlaceBounds.x
		// TODO: can this (h - h)/2 be abstracted explained in an extension method?
		centeredRect.y = (labelPlaceBounds.height - labelDrawBounds.height)/2 + labelPlaceBounds.y
		centeredRect.set(width: ceil(labelDrawBounds.width), height: ceil(labelDrawBounds.height))

		label.drawWithRect(centeredRect, options: drawOptions, context: nil)
	}

}
