/// Represents a point of the grid.
public struct Point: Equatable {
	let x: Int
	let y: Int

	/// Returns up to eight neighbours, which are the points that are horizontally,
	/// vertically, or diagonally adjacent (excluding the current point itself).
	var neighbours: [Point] {
		func neighbours(for index: Int) -> [Int] {
			Array((index - 1)...(index + 1))
		}

		return combine(
			neighbours(for: x),
			neighbours(for: y)
		)
		.map(Point.init)
		.filter { $0 != self }
	}
}
