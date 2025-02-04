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
    private var rawValue: [[String]]

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

    func isCoordinate(_ coordinate: Coordinate, ofKind tileKind: String) -> Bool {
        rawValue[coordinate.y][coordinate.x] == tileKind
    }

    var pirateShipPosition: Coordinate {
        for y in 0..<self.height {
            for x in 0..<self.width {
                let shipPosition = Coordinate(x: x, y: y)
                if self.isCoordinate(
                    shipPosition,
                    ofKind: .pirateShip
                )  {
                    return Coordinate(x: x, y: y)
                }
            }
        }
        fatalError("Expected pirateShipCoordinate")
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
    let nextPirateShipCoordinate = Coordinate(
        x: sea.pirateShipPosition.x + 1,
        y: sea.pirateShipPosition.y
    )

    return sea
        .setting(coordinate: sea.pirateShipPosition, to: .emptyTile)
        .setting(coordinate: nextPirateShipCoordinate, to: .pirateShip)
}

private func isSurroundingSafe(in sea: Sea) -> Bool {
    for surrounding in surroundings(of: sea.pirateShipPosition, in: sea) {
        if sea.isCoordinate(surrounding, ofKind: .navyShip) {
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

private func isWithinSea(_ surrounding: Coordinate, _ seaWidth: Int, _ seaHeight: Int) -> Bool {
    surrounding.y >= 0 &&
    surrounding.y < seaHeight && 
    surrounding.x >= 0 && 
    surrounding.x < seaWidth
}
