public enum GameError: Error {
	case hasReachedEnd
}

/// Represents the game of life at a moment in time.
public struct Game {
	/// The grid of the game that contains all the live and dead cells.
	public private(set) var grid: Grid
	/// The number of generations left to run.
	public private(set) var generationsLeft: Generations

	/// Creates a game of life at a certain moment in time.
	/// - Parameter configuration: The configuration to setup the current generation of the game.
	public init(configuration: Configuration, generations: Generations) {
		self.grid = Grid(size: configuration.size, livePoints: configuration.livePoints)
		self.generationsLeft = generations
	}

	/// Computes the next generation of the game.
	///
	/// At each step in time, the following transitions occur:
	/// 1. Any live cell with two or three live neighbours survives.
	/// 2. Any dead cell with three live neighbours becomes a live cell.
	/// 3. All other live cells die in the next generation. Similarly, all other dead cells stay dead.
	/// - Throws: `GameError.hasReachedEnd` if no generations are left to run the game.
	public mutating func updateToNextGeneration() throws {
		guard !generationsLeft.hasReachedEnd else { return }
		generationsLeft.decrement()

		grid = Grid(
			size: grid.size,
			livePoints: grid.points.filter(shouldLive)
		)
	}

	/// Returns `true` if the cell at `point` should live.
	///
	/// For the rules, please refer to documentation of `updateToNextGeneration()`
	private func shouldLive(point: Point) -> Bool {
		let liveNeighbours = liveNeighbours(around: point)
		let cell = grid[point]

		switch cell {
		case .live where liveNeighbours.isBetween(2...3),
			 .dead where liveNeighbours == 3:
			return true
		default:
			return false
		}
	}

	/// Returns the number of live cells around a certain `point`.
	private func liveNeighbours(around point: Point) -> Int {
		point.neighbours
			.filter { grid.contains($0) }
			.filter { grid[$0] == .live }
			.count
	}
}
