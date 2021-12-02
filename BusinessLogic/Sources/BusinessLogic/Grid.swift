/// Represents the grid of the game containing all the live and dead cells at a moment in time.
public typealias Grid = [[Cell]]

extension Grid {
	/// Returns the current size of the grid.
	var size: Size {
		try! Size(width: count, height: first!.count)
	}

	/// Returns all the points of the grid.
	var points: [Point] {
		func indices(for length: Int) -> [Int] {
			Array<Int>(0..<length)
		}

		return combine(
			indices(for: size.width),
			indices(for: size.height)
		)
		.map(Point.init)
	}

	/// Creates a grid with the defined `size` and `livePoints`.
	init(size: Size, livePoints: [Point]) {
		self.init(
			repeating: Array<Cell>(repeating: .dead, count: size.height),
			count: size.width
		)

		for livePoint in livePoints {
			self[livePoint] = .live
		}
	}

	/// Returns the cell located at a specific `point` in the grid.
	subscript(_ point: Point) -> Cell {
		get { self[point.x][point.y] }
		set { self[point.x][point.y] = newValue }
	}

	/// Returns `true` if the `point` is contained in the grid.
	///
	/// For example,  in a grid of 10x10:
	/// - a point (5, 5) will be contained
	/// - a point (12, 5) will not.
	func contains(_ point: Point) -> Bool {
		return (0..<size.width).contains(point.x)
			&& (0..<size.height).contains(point.y)
	}
}
