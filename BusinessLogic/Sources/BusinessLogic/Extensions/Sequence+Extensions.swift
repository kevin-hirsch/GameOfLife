extension Sequence where Element: Sequence {
	/// Flattens the array.
	///
	/// Same as calling `Array(joined())` or `flatMap { $0 }`
	var flattened: Array<FlattenSequence<Self>.Element> {
		Array(joined())
	}
}

/// Returns all the possible combinations from the 2 arrays.
func combine<Element: Hashable>(
	_ lhs: [Element],
	_ rhs: [Element]
) -> [(Element, Element)] {
	lhs.map { lElement in
		rhs.map { rElement in
			(lElement, rElement)
		}
	}
	.flattened
}
