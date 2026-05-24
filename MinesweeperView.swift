import SwiftUI

struct MinesweeperView: View {
    @State private var game = MinesweeperGame()
    var body: some View {
        VStack {
            ForEach(0..<12, id: \.self) { r in
                HStack { ForEach(0..<9, id: \.self) { c in
                    Rectangle().fill(game.grid[r][c].isRevealed ? .gray : .blue)
                        .onTapGesture { game.reveal(r: r, c: c) }
                }}
            }
        }.navigationTitle("Сапёр")
    }
}
