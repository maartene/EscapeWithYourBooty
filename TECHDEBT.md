# Tech debt
- Usage of tuple (including typealias) for coordinate provides a risk because, you can still use '.0' and '.1'. And then the position matters.
- Use an enum instead of Character so only valid values are allowed in the sea
- nextSea(for: Sea) will likely cause bugs later since it overides the previous location of the ship to .emptyTile while it could also be needed for navy ships.