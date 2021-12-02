/// Initial configuration for the game.
public struct Configuration {
	/// Size of the grid.
	let size: Size
	/// The points at which cells should live.
	/// Can be considered as the seed.
	let livePoints: [Point]
}

public extension Configuration {
	/// Seed that ends on a 4 points square after several generations.
	static let `default` = Configuration(
		size: try! Size(width: 10, height: 10),
		livePoints: [
			Point(x: 3, y: 2),
			Point(x: 4, y: 3),
			Point(x: 2, y: 4),
			Point(x: 3, y: 4),
			Point(x: 4, y: 4)
		])

	/// Seed  that goes on repeating the last generations indefinitely.
	static let infinite = Configuration(
		size: try! Size(width: 10, height: 10),
		livePoints: [
			Point(x: 4, y: 3),
			Point(x: 3, y: 5),
			Point(x: 4, y: 5),
			Point(x: 5, y: 5)
		])
}
