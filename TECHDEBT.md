# Tech debt

## ⚠️ TODO
- nextSea(for: Sea) will likely cause bugs later since it overides the previous location of the ship to .emptyTile while it could also be needed for navy ships.

* Guard on sea bounds is duplicated to multiple places
* Deduplicate finding a ship (navy or pirate)

## ✅ Solved
- determinePirateShipPosition returns (0,0) when pirate ship can't be found. Is this a valid API?
- ✅ Usage of tuple (including typealias) for coordinate provides a risk because, you can still use '.0' and '.1'. And then the position matters.
- ✅ `isWithinSea()` should be part a member of `Sea`.
- Use an enum instead of Character so only valid values are allowed in the sea
