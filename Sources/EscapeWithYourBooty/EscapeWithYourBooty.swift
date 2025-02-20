@main struct EscapeWithYourBooty {
    static func main() {

    }
}

enum Tile: String {
    case pirateShip = "X"
    case navyShip = "N"
    case empty = "0"
}

struct Coordinate {
    let x: Int
    let y: Int
}

enum NavyShipDirection {
    case TopToBottom
    case BottomToTop
}

struct Sea {
    private var rawValue: [[Tile]]

    init(_ rawValue: [[String]]) {
        self.rawValue = rawValue.map { row in
            row.map { Tile(rawValue: $0)! }
        }
        navyShipDirection = navyShipPosition?.y == 0 ? .TopToBottom : .BottomToTop
    }

    var navyShipDirection: NavyShipDirection = .BottomToTop

    var width: Int {
        rawValue[0].count
    }

    var height: Int {
        rawValue.count
    }

    func setting(coordinate: Coordinate, to tileKind: Tile) -> Self {
        var mutableSelf = self
        mutableSelf.rawValue[coordinate.y][coordinate.x] = tileKind
        return mutableSelf
    }

    func isCoordinate(_ coordinate: Coordinate, ofKind tileKind: Tile) -> Bool {
        rawValue[coordinate.y][coordinate.x] == tileKind
    }

    var pirateShipPosition: Coordinate {
        guard let pirateShip = findCoordinateOf(type: .pirateShip) else {
            fatalError("Expected pirateShipCoordinate")
        }
        return pirateShip
    }

    var navyShipPosition: Coordinate? {
        findCoordinateOf(type: .navyShip)
    }

    private func findCoordinateOf(type: Tile) -> Coordinate? {
        for y in 0..<self.height {
            for x in 0..<self.width {
                let shipPosition = Coordinate(x: x, y: y)
                if self.isCoordinate(
                    shipPosition,
                    ofKind: type
                ) {
                    return Coordinate(x: x, y: y)
                }
            }
        }
        return nil
    }

    func isWithinSea(_ surrounding: Coordinate) -> Bool {
        surrounding.y >= 0 && surrounding.y < height && surrounding.x >= 0 && surrounding.x < width
    }
}

func isThisASafeRoute(in sea: Sea) -> Bool {
    if !isSurroundingSafe(in: sea) {
        return false
    }

    if let upcomingSea = nextSea(for: sea) {
        return isThisASafeRoute(in: upcomingSea)
    }

    return true
}

private func nextSea(for sea: Sea) -> Sea? {
    let nextPirateShipCoordinate = Coordinate(
        x: sea.pirateShipPosition.x + 1,
        y: sea.pirateShipPosition.y
    )

    var updatedSea = sea

    if let currentNavyShipCoordinate = sea.navyShipPosition {
        let nextNavyShipCoordinate = Coordinate(
            x: currentNavyShipCoordinate.x,
            y: sea.navyShipDirection == .TopToBottom
                ? currentNavyShipCoordinate.y + 1 : currentNavyShipCoordinate.y - 1
        )
        if sea.isWithinSea(nextNavyShipCoordinate) {
            updatedSea = updatedSea.setting(coordinate: currentNavyShipCoordinate, to: .empty)
                .setting(coordinate: nextNavyShipCoordinate, to: .navyShip)
        }
    }

    guard nextPirateShipCoordinate.x < sea.width else {
        return nil
    }

    return
        updatedSea
        .setting(coordinate: sea.pirateShipPosition, to: .empty)
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
        .init(x: 1, y: 1),
    ]
    return
        offsets
        .map { offset in Coordinate(x: shipPosition.x + offset.x, y: shipPosition.y + offset.y) }
        .filter { sea.isWithinSea($0) }
}
