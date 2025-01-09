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
    if !isSurroundingSafe(in: sea) {
        return false
    }
    
    if sea[0].count > 1 {
        let nextSea = nextSea(for: sea)
        return isSurroundingSafe(in: nextSea)
    }
    return true
}

private func nextSea(for sea: Sea) -> Sea {
    let pirateShipCoordinate = Coordinate(y: 0, x: 0)
    let nextPirateShipCoordinate = Coordinate(y: 0, x: 1)
    var mutableSea = sea
    mutableSea[pirateShipCoordinate.y][pirateShipCoordinate.x] = "0"
    mutableSea[nextPirateShipCoordinate.y][nextPirateShipCoordinate.x] = "X"
    return mutableSea
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
