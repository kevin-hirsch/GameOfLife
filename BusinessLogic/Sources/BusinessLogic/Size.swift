public enum SizeError: Error {
	case invalidSize
}

/// Represents the size of the grid.
///
/// `width` and `height` must be greater than 0.
public struct Size: Equatable {
	let width: Int
	let height: Int

	/// Creates a new size for a grid.
	/// `width` and `height` must be greater than 0.
	/// - Throws: `SizeError.invalidSize` if `width` or `height` is less than or equal to 0
	init(width: Int, height: Int) throws {
		guard width > 0 && height > 0 else {
			throw SizeError.invalidSize
		}

		self.width = width
		self.height = height
	}
}
