@main struct EscapeWithYourBooty {
    static func main() {
        
    }
}

extension String {
    static let pirateShip = "X"
    static let navyShip = "N"
    static let emptyTile = "0"
}

struct Coordinate {
    let y: Int
    let x: Int
}

typealias Sea = [[String]]

func isThisASafeRoute(in sea: Sea) -> Bool {
    if !isSurroundingSafe(in: sea) {
        return false
    }
    
    if sea[0].count > 1 {
        let nextSea = nextSea(for: sea)
        if !isSurroundingSafe(in: nextSea) {
            return false
        } 
    }
    if sea[0].count > 2 {
        let stepOneSea = nextSea(for: sea)
        let stepTwoSea = nextSea(for: stepOneSea)
        if  !isSurroundingSafe(in: stepTwoSea) {
            return false
        }
    }
    return true
}

private func nextSea(for sea: Sea) -> Sea {
    let pirateShipCoordinate = determinePirateShipPosition(sea: sea)
    let nextPirateShipCoordinate = Coordinate(y: pirateShipCoordinate.y, x: pirateShipCoordinate.x + 1)
    var mutableSea = sea
    mutableSea[pirateShipCoordinate.y][pirateShipCoordinate.x] = .emptyTile
    mutableSea[nextPirateShipCoordinate.y][nextPirateShipCoordinate.x] = .pirateShip
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
        .init(y: -1, x: -1), 
        .init(y: -1, x: 0), 
        .init(y: -1, x: 1), 
        .init(y: 0, x: -1),
        .init(y: 0, x: 1), 
        .init(y: 1, x: -1), 
        .init(y: 1, x: 0), 
        .init(y: 1, x: 1)
    ]
    return offsets
        .map { offset in Coordinate(y: shipPosition.y + offset.y, x: shipPosition.x + offset.x) }
        .filter { isWithinSea($0, seaWidth, seaHeight) }
}

private func determinePirateShipPosition(sea: Sea) -> Coordinate {
    let shipPosition = Coordinate(y: 10, x: 10)
    for y in 0..<sea.count {
        for x in 0..<sea[y].count {
            if sea[y][x] == .pirateShip {
                return Coordinate(y: y, x: x)
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
