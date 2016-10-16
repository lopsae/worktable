import Foundation


extension IndexPath {

	func toArray() -> [Int] {
		var indexes = [Int](repeating: 0, count: self.count)
		for index in 0 ..< self.count {
			indexes[index] = self[index]
		}
		return indexes
	}

}
