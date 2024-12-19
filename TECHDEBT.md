# Tech debt
- Usage of tuple (including typealias) for coordinate provides a risk because, you can still use '.0' and '.1'. And then the position matters.
- Use an enum instead of Character so only valid values are allowed in the sea