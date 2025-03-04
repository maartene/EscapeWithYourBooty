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
    var x: Int
    let y: Int
}

extension Coordinate: Equatable { }

enum NavyShipDirection {
    case TopToBottom
    case BottomToTop
}

struct Sea {
    private var rawValue: [[Tile]]
    var navyShip: NavyShip?
    var pirateShip = PirateShip()

    init(_ rawValue: [[String]]) {
        self.rawValue = rawValue.map { row in
            row.map { Tile(rawValue: $0)! }
        }

        self.pirateShip.position = findCoordinateOf(type: .pirateShip)!

        if let navyShipPosition = findCoordinateOf(type: .navyShip) {
            navyShip = NavyShip(position: navyShipPosition)
        }
    }

    var navyShipDirection: NavyShipDirection {
        navyShip?.direction ?? .BottomToTop
    }

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

    

    func nextSea() -> Sea? {
        var updatedSea = self

        updatedSea.navyShip?.updatePosition(seaHeight: height)

        updatedSea.pirateShip.updatePosition() 

        guard updatedSea.pirateShip.position.x < width else {
            return nil
        }

        return
            updatedSea
//            .setting(coordinate: pirateShipPosition, to: .empty)
//            .setting(coordinate: nextPirateShipCoordinate, to: .pirateShip)
    }   
}

func isThisASafeRoute(in sea: Sea) -> Bool {
    if !isSurroundingSafe(in: sea) {
        return false
    }

    if let upcomingSea = sea.nextSea() {
        return isThisASafeRoute(in: upcomingSea)
    }

    return true
}

private func isSurroundingSafe(in sea: Sea) -> Bool {
    for surrounding in surroundings(of: sea.pirateShip.position, in: sea) {
        if sea.navyShip?.position == surrounding {
            return false
        }
    }
    return true
}

private func surroundings(of shipPosition: Coordinate, in sea: Sea) -> [Coordinate] {
    func isWithinSea(_ surrounding: Coordinate) -> Bool {
        surrounding.y >= 0 && surrounding.y < sea.height && surrounding.x >= 0 && surrounding.x < sea.width
    }

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
        .filter { isWithinSea($0) }
}