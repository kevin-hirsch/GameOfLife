//
//  GridTests.swift
//  GameOfLifeTests
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import XCTest
import Nimble
@testable import BusinessLogic

class GridTests: XCTestCase {
	var sut: Grid!

	// MARK: - Configuration

	func testAllDeadCells() {
		let size = try! Size(width: 4, height: 5)
		sut = Grid(size: size, livePoints: [])
		expect(self.sut.flattened.allSatisfy { $0 == .dead }) == true
	}

	func testAllLiveCells() {
		let size = try! Size(width: 2, height: 2)
		let livePoints = [
			Point(x: 0, y: 0),
			Point(x: 1, y: 0),
			Point(x: 0, y: 1),
			Point(x: 1, y: 1)
		]

		sut = Grid(size: size, livePoints: livePoints)

		expect(self.sut.flattened.allSatisfy { $0 == .live }) == true
	}

	func testBasicConfiguration() {
		let size = try! Size(width: 3, height: 3)
		let livePoints = [
			Point(x: 0, y: 0),
			Point(x: 1, y: 1),
			Point(x: 1, y: 2)
		]

		sut = Grid(size: size, livePoints: livePoints)

		for (point, cell) in sut.pointsAndCells {
			if livePoints.contains(point) {
				expect(cell) == .live
			} else {
				expect(cell) == .dead
			}
		}
	}

	// MARK: - Size

	func testGridReturnsTheCorrectSize() {
		func testCase(gridWithSize size: Size) {
			sut = Grid(size: size, livePoints: [])
			expect(self.sut.size) == size
		}

		testCase(gridWithSize: try! Size(width: 1, height: 1))
		testCase(gridWithSize: try! Size(width: 10, height: 10))
		testCase(gridWithSize: try! Size(width: 4, height: 6))
		testCase(gridWithSize: try! Size(width: 5, height: 3))
	}

	// MARK: - Points (var/subscript/contains)

	func testAllPointsAreCorrectlyReturned() {
		let size = try! Size(width: 2, height: 2)
		sut = Grid(size: size, livePoints: [])

		let expectedPoints = [
			Point(x: 0, y: 0),
			Point(x: 0, y: 1),
			Point(x: 1, y: 0),
			Point(x: 1, y: 1)
		]

		expect(self.sut.points) == expectedPoints
	}

	func testCorrectCellIsReturnedForRelatedPoint() {
		let size = try! Size(width: 2, height: 2)
		let livePoints = [Point(x: 0, y: 0), Point(x: 1, y: 1)]
		sut = Grid(size: size, livePoints: livePoints)

		expect(self.sut[Point(x: 0, y: 0)]) == .live
		expect(self.sut[Point(x: 0, y: 1)]) == .dead
		expect(self.sut[Point(x: 1, y: 0)]) == .dead
		expect(self.sut[Point(x: 1, y: 1)]) == .live
	}

	func testContainsReturnsTrueIfPointIsInsideGrid() {
		let size = try! Size(width: 2, height: 2)
		sut = Grid(size: size, livePoints: [])

		expect(self.sut.contains(Point(x: 0, y: 0))) == true
		expect(self.sut.contains(Point(x: 0, y: 1))) == true
		expect(self.sut.contains(Point(x: 1, y: 0))) == true
		expect(self.sut.contains(Point(x: 1, y: 1))) == true
	}

	func testContainsReturnsFalseIfPointIsNotInsideGrid() {
		let size = try! Size(width: 2, height: 2)
		sut = Grid(size: size, livePoints: [])

		expect(self.sut.contains(Point(x: -1, y: 0))) == false
		expect(self.sut.contains(Point(x: -1, y: -1))) == false
		expect(self.sut.contains(Point(x: 1, y: 3))) == false
		expect(self.sut.contains(Point(x: 4, y: 5))) == false
	}
}
