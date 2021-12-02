//
//  GameView.swift
//  GameOfLife
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import SwiftUI
import BusinessLogic

/// View of the game.
struct GameView: View {
	/// The game to display.
	@State private(set) var game: Game

	private let timer = Timer.publish(every: 0.5, on: .main, in: .common)

	private var generationsLeft: String {
		switch game.generationsLeft {
		case .infinite:
			return "∞"
		case .finite(let number):
			return "\(number)"
		}
	}

	var body: some View {
		VStack {
			GridView(game: game)
				.onReceive(timer) { _ in
					try? game.updateToNextGeneration()
				}

			Button("Start") {
				_ = timer.connect()
			}
			.padding()

			Text("Generations left: \(generationsLeft)")
				.padding()
		}
	}
}

struct GameView_Previews: PreviewProvider {
	static var previews: some View {
		let game = Game(
			configuration: .default,
			generations: .finite(5)
		)

		GameView(game: game)
	}
}
