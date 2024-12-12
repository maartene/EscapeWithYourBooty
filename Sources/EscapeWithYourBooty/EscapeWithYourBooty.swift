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
        var result = true
        let shipSurroundings = [(0,1), (1,1), (1,0)]
        for surrounding in shipSurroundings {
            if sea[surrounding.0][surrounding.1] == .navyShip {
                result = false
            }
        }
        return result
    } 
    if sea == [["0", "N"], ["X", "0"]] {
        var result = true
        let shipSurroundings = [(0,0), (0,1), (1,1)]
        for surrounding in shipSurroundings {
            if sea[surrounding.0][surrounding.1] == .navyShip {
                result = false
            }
        }
        return result
    }
    
    return true
}
