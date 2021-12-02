//
//  GenerationsTests.swift
//  GameOfLifeTests
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import XCTest
import Nimble
@testable import BusinessLogic

class GenerationsTests: XCTestCase {
	var sut: Generations!

    func testInfiniteGenerationsCannotDecrement() {
		sut = Generations.infinite
		sut.decrement()
		expect(self.sut) == .infinite
    }

	func testInfiniteGenerationsCannotReachEnd() {
		sut = Generations.infinite
		expect(self.sut.hasReachedEnd) == false
	}

	func testFiniteGenerationsCanDecrement() {
		sut = Generations.finite(1)
		sut.decrement()
		expect(self.sut) == .finite(0)
	}

	func testFiniteGenerationsCanReachEnd() throws {
		sut = Generations.finite(1)
		sut.decrement()
		expect(self.sut.hasReachedEnd) == true
	}

	func testFiniteGenerationsDecrementAfterReachesEndStillReachEnd() throws {
		sut = Generations.finite(0)
		expect(self.sut.hasReachedEnd) == true
		sut.decrement()
		expect(self.sut.hasReachedEnd) == true
	}
}
