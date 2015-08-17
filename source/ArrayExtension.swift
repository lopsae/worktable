

extension Array {
    
    var tail: T? {
        get {
            return last
        }
        
        mutating set(newTail) {
            if count == 0 {
                append(newTail!)
            } else {
                self[count - 1] = newTail!
            }
        }
    }
    
}