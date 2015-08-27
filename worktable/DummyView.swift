import UIKit


/**
 * UIView that draws a pattern inside all its drawable area and a border around
 * its frame. Good for testing scrolling and layouts.
 */
class DummyView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.lightGrayColor()
	}


	required init(coder: NSCoder) {
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
	}

}
