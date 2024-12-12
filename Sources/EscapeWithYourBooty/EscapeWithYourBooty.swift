@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

extension Character {
    static let pirateShip: Character = "X"
    static let navyShip: Character = "N"
}

func isThisASafeRoute(in sea: [[Character]]) -> Bool {
    let seaHeight = sea.count
    let seaWidth = sea[0].count
    var result = true

    let shipPosition = determinePirateShipPosition(sea: sea)
    let offsets = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1,1)]
    let shipSurroundings = offsets.map { offset in
        return (shipPosition.0 + offset.0, shipPosition.1 + offset.1)
    }.filter { surrounding in
        isWithinSea(surrounding, seaWidth, seaHeight)
    }
    for surrounding in shipSurroundings {
        if sea[surrounding.0][surrounding.1] == .navyShip {
            result = false
        }
    }
    return result
}

private func determinePirateShipPosition(sea: [[Character]]) -> (Int, Int) {
    var shipPosition = (10, 10)
    for y in 0..<sea.count {
        for x in 0..<sea[y].count {
            if sea[y][x] == .pirateShip {
                return (x, y)
            }
        }

    }
    return shipPosition
}

private func isWithinSea(_ surrounding: (Int, Int), _ seaWidth: Int, _ seaHeight: Int) -> Bool {
    surrounding.0 >= 0 && 
        surrounding.0 < seaHeight && 
        surrounding.1 >= 0 && 
        surrounding.1 < seaWidth
}
