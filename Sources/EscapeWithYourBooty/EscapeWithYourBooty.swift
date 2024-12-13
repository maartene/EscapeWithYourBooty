@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

extension Character {
    static let pirateShip: Character = "X"
    static let navyShip: Character = "N"
}

func isThisASafeRoute(in sea: [[Character]]) -> Bool {
    var result = true
    for surrounding in surroundings(of: determinePirateShipPosition(sea: sea), in: sea) {
        if sea[surrounding.0][surrounding.1] == .navyShip {
            result = false
        }
    }
    return result
}

private func surroundings(of shipPosition: (Int, Int), in sea: [[Character]]) -> [(Int, Int)] {
    let seaHeight = sea.count
    let seaWidth = sea[0].count
    let offsets = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1,1)]
    return offsets
        .map { offset in (shipPosition.0 + offset.0, shipPosition.1 + offset.1) }
        .filter { isWithinSea($0, seaWidth, seaHeight) }
}

private func determinePirateShipPosition(sea: [[Character]]) -> (Int, Int) {
    let shipPosition = (10, 10)
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
