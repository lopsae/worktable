import Foundation


extension IndexPath {

	static func withIndexes(_ indexes: [Int]) -> IndexPath {
		var indexPath = IndexPath()
		for index in indexes {
			indexPath = indexPath.appending(index)
		}
		return indexPath
	}


	static func withIndexes(_ indexes: Int...) -> IndexPath {
		return self.withIndexes(indexes)
	}


	func toArray() -> [Int] {
		var indexes = [Int](repeating: 0, count: self.count)
		for index in 0 ..< self.count {
			indexes[index] = self[index]
		}
		return indexes
	}

}
