import Foundation


extension NSIndexPath {

	static func withIndexes(indexes: [Int]) -> NSIndexPath {
		var indexPath = NSIndexPath()
		for index in indexes {
			indexPath = indexPath.indexPathByAddingIndex(index)
		}
		return indexPath
	}


	static func withIndexes(indexes: Int...) -> NSIndexPath {
		return self.withIndexes(indexes)
	}


	func toArray() -> [Int] {
		var indexes = [Int](count: self.length, repeatedValue: 0)
		for index in 0 ..< self.length {
			indexes[index] = self.indexAtPosition(index)
		}
		return indexes
	}

}
