//
//  CombineTests.swift
//  GameOfLifeTests
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import XCTest
import Nimble
@testable import BusinessLogic

private struct Combination: Equatable {
	let tuple: (Int, Int)

	init(_ tuple: (Int, Int)) {
		self.tuple = tuple
	}

	static func == (lhs: Combination, rhs: Combination) -> Bool {
		lhs.tuple.0 == rhs.tuple.0 && lhs.tuple.1 == rhs.tuple.1
	}
}

class CombineTests: XCTestCase {
	func testCombineEmptyArraysReturnsEmptyArray() {
		expect(self.combine([], [])).to(beEmpty())
	}

	func testCombineEmptyArrayWithSomeArrayReturnsEmptyArray() {
		let someArray = [1, 2, 3]
		expect(self.combine([], someArray)).to(beEmpty())
		expect(self.combine(someArray, [])).to(beEmpty())
	}

	func testCombineTwoArraysReturnsAllCombinations_1() {
		expect(self.combine([1, 2], [1])) == combinations([(1, 1), (2, 1)])
	}

	func testCombineTwoArraysReturnsAllCombinations_2() {
		expect(self.combine([1, 2, 3], [4, 5, 6]))
			== combinations([
				(1, 4), (1, 5), (1, 6),
				(2, 4), (2, 5), (2, 6),
				(3, 4), (3, 5), (3, 6)
			])
	}

	// MARK: - Helpers

	private func combine(_ lhs: [Int], _ rhs: [Int]) -> [Combination] {
		BusinessLogic.combine(lhs, rhs)
			.map(Combination.init)
	}

	private func combinations(_ tuples: [(Int, Int)]) -> [Combination] {
		tuples.map(Combination.init)
	}
}
