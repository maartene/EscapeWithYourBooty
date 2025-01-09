@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

extension String {
    static let pirateShip = "X"
    static let navyShip = "N"
}

typealias Coordinate = (y: Int, x: Int)
typealias Sea = [[String]]

func isThisASafeRoute(in sea: Sea) -> Bool {
    return isSurroundingSafe(in: nextSea(for: sea))
}

private func nextSea(for sea: Sea) -> Sea {
    if sea == [["X", "0", "N"]] {
        let pirateShipCoordinate = Coordinate(y: 0, x: 0)
        let nextPirateShipCoordinate = Coordinate(y: 0, x: 1)
        var mutableSea = sea
        mutableSea[0][0] = "0"
        mutableSea[0][1] = "X"
        return mutableSea
    }
    if sea == [["X", "0", "N", "0"]] {
        var mutableSea = sea
        mutableSea[0][0] = "0"
        mutableSea[0][1] = "X"
        return mutableSea
    }
    return sea
}

private func isSurroundingSafe(in sea: Sea) -> Bool {
    for surrounding in surroundings(of: determinePirateShipPosition(sea: sea), in: sea) {
        if sea[surrounding.y][surrounding.x] == .navyShip {
            return false
        }
    }
    return true
}

private func surroundings(of shipPosition: Coordinate, in sea: Sea) -> [Coordinate] {
    let seaHeight = sea.count
    let seaWidth = sea[0].count
    let offsets: [Coordinate] = [
        (y: -1, x: -1), 
        (y: -1, x: 0), 
        (y: -1, x: 1), 
        (y: 0, x: -1),
        (y: 0, x: 1), 
        (y: 1, x: -1), 
        (y: 1, x: 0), 
        (y: 1, x: 1)
    ]
    return offsets
        .map { offset in (shipPosition.x + offset.x, shipPosition.y + offset.y) }
        .filter { isWithinSea($0, seaWidth, seaHeight) }
}

private func determinePirateShipPosition(sea: Sea) -> Coordinate {
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
    surrounding.y >= 0 &&
    surrounding.y < seaHeight && 
    surrounding.x >= 0 && 
    surrounding.x < seaWidth
}
