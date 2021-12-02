//
//  GameOfLifeApp.swift
//  GameOfLife
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import SwiftUI
import BusinessLogic

@main
struct GameOfLifeApp: App {
	let game = Game(
		configuration: .default,
		generations: .finite(5)
	)

	var body: some Scene {
		WindowGroup {
			GameView(game: game)
		}
	}
}
