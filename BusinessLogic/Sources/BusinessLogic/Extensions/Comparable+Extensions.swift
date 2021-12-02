extension Comparable {
	/// Returns true if the value is contained within `closedRange`.
	///
	/// Is the same as calling `closedRange.contains(self)` but sometimes
	/// calling it this way is not the most declarative way.
	func isBetween(_ closedRange: ClosedRange<Self>) -> Bool {
		return closedRange.contains(self)
	}
}
