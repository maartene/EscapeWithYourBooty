@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

extension Character {
    static let pirateShip: Character = "X"
    static let navyShip: Character = "N"
}

typealias Coordinate = (y: Int, x: Int)

func isThisASafeRoute(in sea: [[Character]]) -> Bool {
    var result = true
    for surrounding in surroundings(of: determinePirateShipPosition(sea: sea), in: sea) {
        if sea[surrounding.0][surrounding.1] == .navyShip {
            result = false
        }
    }
    return result
}

private func surroundings(of shipPosition: Coordinate, in sea: [[Character]]) -> [Coordinate] {
    let seaHeight = sea.count
    let seaWidth = sea[0].count
    let offsets: [Coordinate] = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1,1)]
    return offsets
        .map { offset in (shipPosition.x + offset.x, shipPosition.y + offset.y) }
        .filter { isWithinSea($0, seaWidth, seaHeight) }
}

private func determinePirateShipPosition(sea: [[Character]]) -> Coordinate {
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

private func isWithinSea(_ surrounding: Coordinate, _ seaWidth: Int, _ seaHeight: Int) -> Bool {
    surrounding.0 >= 0 &&
        surrounding.0 < seaHeight && 
        surrounding.1 >= 0 && 
        surrounding.1 < seaWidth
}
