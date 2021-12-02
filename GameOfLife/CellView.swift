//
//  CellView.swift
//  GameOfLife
//
//  Created by Kevin HIRSCH on 02/12/2021.
//

import SwiftUI
import BusinessLogic

/// View of a cell that can be live or dead.
struct CellView: View {
	let cell: Cell

	var body: some View {
		Rectangle()
			.frame(width: 30, height: 30)
			.foregroundColor(cell == .live ? .black : .gray)
	}
}

struct CellView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			CellView(cell: .live)
				.previewLayout(PreviewLayout.sizeThatFits)
				.padding()
				.previewDisplayName("Live")

			CellView(cell: .dead)
				.previewLayout(PreviewLayout.sizeThatFits)
				.padding()
				.previewDisplayName("Dead")
		}
	}
}
