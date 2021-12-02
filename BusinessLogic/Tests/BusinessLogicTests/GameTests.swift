//
//  GameTests.swift
//  GameOfLifeTests
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import XCTest
import Nimble
@testable import BusinessLogic

private let size = try! Size(width: 10, height: 12)

class GameTests: XCTestCase {
	var sut: Game!

	// MARK: - Generations logic

	func testUpdateToNextVersionDoesNotThrowErrorIfEnoughGenerationsLeft() {
		testCase(updateToNextVersionShouldThrow: false, ifGenerationsLeft: .finite(1))
	}

	func testUpdateToNextVersionDoesThrowErrorIfRanOutOfGenerations() {
		testCase(updateToNextVersionShouldThrow: false, ifGenerationsLeft: .finite(0))
	}

	func testUpdateToNextVersionDoesNotThrowErrorIfInfiniteGenerations() {
		testCase(updateToNextVersionShouldThrow: false, ifGenerationsLeft: .infinite)
	}

	func testUpdateToNextVersionDecrementsGenerationsLeft() {
		sut = Game(
			configuration: .init(size: size, livePoints: []),
			generations: .finite(1)
		)

		try! sut.updateToNextGeneration()
		expect(self.sut.generationsLeft) == .finite(0)
	}

	// MARK: - Live/Dead logic

	func testLiveCellWithTwoOrThreeLiveNeighboursSurvives() {
		testCase(cell: .live, withLiveNeighbours: 2, becomes: .live)
		testCase(cell: .live, withLiveNeighbours: 3, becomes: .live)
	}

	func testLiveCellWithLessThanTwoOrMoreThanThreeLiveNeighboursDies() {
		testCase(cell: .live, withLiveNeighbours: 0, becomes: .dead)
		testCase(cell: .live, withLiveNeighbours: 1, becomes: .dead)
		testCase(cell: .live, withLiveNeighbours: 4, becomes: .dead)
		testCase(cell: .live, withLiveNeighbours: 8, becomes: .dead)
	}

	func testDeadCellWithThreeLiveNeighboursBecomesLive() {
		testCase(cell: .dead, withLiveNeighbours: 3, becomes: .live)
	}

	func testDeadCellWithLessOrMoreThanThreeLiveNeighboursStaysDead() {
		testCase(cell: .dead, withLiveNeighbours: 0, becomes: .dead)
		testCase(cell: .dead, withLiveNeighbours: 1, becomes: .dead)
		testCase(cell: .dead, withLiveNeighbours: 2, becomes: .dead)
		testCase(cell: .dead, withLiveNeighbours: 4, becomes: .dead)
		testCase(cell: .dead, withLiveNeighbours: 8, becomes: .dead)
	}

	// MARK: - Helpers

	private func testCase(
		updateToNextVersionShouldThrow shouldThrow: Bool,
		ifGenerationsLeft generationsLeft: Generations
	) {
		sut = Game(
			configuration: .init(size: size, livePoints: []),
			generations: generationsLeft
		)

		if shouldThrow {
			expect(try self.sut.updateToNextGeneration())
				.to(throwError(GameError.hasReachedEnd))
		} else {
			expect(try self.sut.updateToNextGeneration())
				.toNot(throwError())
		}
	}

	private func testCase(
		cell: Cell,
		withLiveNeighbours liveNeighbours: Int,
		becomes expectedCell: Cell
	) {
		let pointUnderTest = Point(x: 5, y: 5)
		var livePoints = Array(pointUnderTest.neighbours[..<liveNeighbours])

		if cell == .live {
			livePoints.append(pointUnderTest)
		}

		sut = Game(
			configuration: .init(size: size, livePoints: livePoints),
			generations: .infinite
		)

		try! sut.updateToNextGeneration()

		for (point, cell) in sut.grid.pointsAndCells {
			if point == pointUnderTest {
				expect(cell) == expectedCell
			}
		}
	}
}

extension Grid {
	/// Returns an array of tuples containing all points with related cell.
	var pointsAndCells: [(Point, Cell)] {
		points.map { ($0, self[$0]) }
	}
}
