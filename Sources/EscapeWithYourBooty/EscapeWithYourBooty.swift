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
    let x: Int
    let y: Int
}

struct Sea {
    private(set) var rawValue: [[String]]

    init(_ rawValue: [[String]]) {
        self.rawValue = rawValue
    }

    var width: Int {
        rawValue[0].count
    }

    var height: Int {
        rawValue.count
    }

    func setting(coordinate: Coordinate, to tileKind: String) -> Self {
        var mutableSelf = self
        mutableSelf.rawValue[coordinate.y][coordinate.x] = tileKind
        return mutableSelf
    }
}

func isThisASafeRoute(in sea: Sea) -> Bool {
    if !isSurroundingSafe(in: sea) {
        return false
    }
    
    if sea.width > 1 {
        let nextSea = nextSea(for: sea)
        if !isSurroundingSafe(in: nextSea) {
            return false
        } 
    }
    if sea.width > 2 {
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
    let nextPirateShipCoordinate = Coordinate(x: pirateShipCoordinate.x + 1,  y: pirateShipCoordinate.y)

    return sea
        .setting(coordinate: pirateShipCoordinate, to: .emptyTile)
        .setting(coordinate: nextPirateShipCoordinate, to: .pirateShip)
}

private func isSurroundingSafe(in sea: Sea) -> Bool {
    for surrounding in surroundings(of: determinePirateShipPosition(sea: sea), in: sea) {
        if sea.rawValue[surrounding.y][surrounding.x] == .navyShip {
            return false
        }
    }
    return true
}

private func surroundings(of shipPosition: Coordinate, in sea: Sea) -> [Coordinate] {
    let offsets: [Coordinate] = [
        .init(x: -1, y: -1), 
        .init(x: -1, y: 0), 
        .init(x: -1, y: 1), 
        .init(x: 0, y: -1),
        .init(x: 0, y: 1), 
        .init(x: 1, y: -1), 
        .init(x: 1, y: 0), 
        .init(x: 1, y: 1)
    ]
    return offsets
        .map { offset in Coordinate(x: shipPosition.x + offset.x, y: shipPosition.y + offset.y) }
        .filter { isWithinSea($0, sea.width, sea.height) }
}

private func determinePirateShipPosition(sea: Sea) -> Coordinate {
    let shipPosition = Coordinate(x: 10, y: 10)
    for y in 0..<sea.height {
        for x in 0..<sea.rawValue[y].count {
            if sea.rawValue[y][x] == .pirateShip {
                return Coordinate(x: x, y: y)
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
