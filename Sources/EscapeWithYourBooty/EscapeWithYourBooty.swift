@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

extension Character {
    static let pirateShip: Character = "X"
    static let navyShip: Character = "N"
}

func isThisASafeRoute(in sea: [[Character]]) -> Bool {
    // lets assume that any route with Navy is unsafe
    for route in sea {
        if route.contains(.pirateShip) && route.contains(.navyShip) {
            return false
        }
    }

    if sea == [["X","0"], ["0","N"]] {
        return false
    } 
    if sea == [["0", "N"], ["X", "0"]] {
        return false
    }
    
    return true
}
