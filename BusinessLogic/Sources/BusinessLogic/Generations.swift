/// Number of generations to play in the game of life.
public enum Generations: Equatable {
	case infinite
	case finite(Int)

	/// Returns `true` if number of generations left is 0.
	var hasReachedEnd: Bool {
		switch self {
		case .infinite:
			return false
		case .finite(let number):
			return number == 0
		}
	}

	/// Decrements the number of generations left until it reaches 0.
	mutating func decrement() {
		switch self {
		case .infinite:
			break
		case .finite(let number):
			self = .finite(max(0, number - 1))
		}
	}
}
