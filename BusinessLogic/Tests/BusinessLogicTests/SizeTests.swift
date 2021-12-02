//
//  SizeTests.swift
//  GameOfLifeTests
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import XCTest
import Nimble
@testable import BusinessLogic

class SizeTests: XCTestCase {
	func testSizeThrowsErrorIfLessThanOrEqualToZero() {
		let error = SizeError.invalidSize
		expect(try Size(width: 0, height: 0)).to(throwError(error))
		expect(try Size(width: 1, height: 0)).to(throwError(error))
		expect(try Size(width: 0, height: 1)).to(throwError(error))
	}

	func testSizeDoesNotThrowErrorIfBiggerThanZero() {
		expect(try Size(width: 1, height: 1)).toNot(throwError())
		expect(try Size(width: 5, height: 5)).toNot(throwError())
	}
}
