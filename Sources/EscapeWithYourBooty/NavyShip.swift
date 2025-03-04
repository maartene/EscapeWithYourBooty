struct NavyShip {
    private(set) var direction: NavyShipDirection
    var position: Coordinate
    
    init(position: Coordinate) {
        self.position = position
        self.direction = position.y == 0 ? .TopToBottom : .BottomToTop
    }

    mutating func updatePosition(seaHeight: Int) {
        guard seaHeight > 1 else {
            return 
        }

        determineDirection(currentPosition: position, seaHeight: seaHeight)
        position = nextPosition
    }

    private mutating func determineDirection(currentPosition: Coordinate, seaHeight: Int) {
        if currentPosition.y == 0 {
            direction = .TopToBottom
        }

        if currentPosition.y == seaHeight - 1 {
            direction = .BottomToTop
        }
    }

    private var nextPosition: Coordinate {
        let nextNavyShipCoordinate = Coordinate(
            x: position.x,
            y: direction == .TopToBottom
                ? position.y + 1 : position.y - 1
        )

        return nextNavyShipCoordinate
    }
    
}