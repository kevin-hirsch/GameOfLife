//
//  PointTests.swift
//  GameOfLifeTests
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import XCTest
import Nimble
@testable import BusinessLogic

class PointTests: XCTestCase {
	func testNeighboursReturns8PointExcludingSelf() {
		let sut = Point(x: 10, y: 4)
		expect(sut.neighbours) == [
			Point(x: 9, y: 3),
			Point(x: 9, y: 4),
			Point(x: 9, y: 5),
			Point(x: 10, y: 3),
			Point(x: 10, y: 5),
			Point(x: 11, y: 3),
			Point(x: 11, y: 4),
			Point(x: 11, y: 5)
		]
	}
}

