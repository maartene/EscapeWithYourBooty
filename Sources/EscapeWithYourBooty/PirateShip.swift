struct PirateShip {
    var position: Coordinate
    
    init(position: Coordinate = Coordinate(x: 0, y: 0)) {
        self.position = position
    }

    mutating func updatePosition() {
        position.x = position.x + 1
    }
}