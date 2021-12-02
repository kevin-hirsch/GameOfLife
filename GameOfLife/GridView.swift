//
//  GridView.swift
//  GameOfLife
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import SwiftUI
import BusinessLogic

/// View of the grid.
struct GridView: View {
	var game: Game

	var body: some View {
		HStack(spacing: Constants.cellSpacing) {
			ForEach(game.grid, id: \.self) { column in
				VStack(spacing: Constants.cellSpacing) {
					ForEach(column, id: \.self) { cell in
						CellView(cell: cell)
					}
				}
			}
		}
	}
}

struct GridView_Previews: PreviewProvider {
	static var previews: some View {
		let game = Game(
			configuration: .default,
			generations: .finite(5)
		)

		GridView(game: game)
			.previewLayout(PreviewLayout.sizeThatFits)
			.padding()
	}
}
