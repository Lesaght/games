import SwiftUI
import Observation

struct MSCell: Identifiable { let id = UUID(); let row: Int; let col: Int; var isMine = false; var isRevealed = false; var isFlagged = false; var adjacentMines = 0 }

@Observable
final class MinesweeperGame {
    var grid: [[MSCell]] = []; var state: GameState = .ready; var isWon = false; var flagsPlaced = 0
    init() { reset() }
    func reset() {
        grid = (0..<12).map { r in (0..<9).map { c in MSCell(row: r, c: c) } }
        for _ in 0..<15 { let r=Int.random(in: 0..<12), c=Int.random(in: 0..<9); grid[r][c].isMine = true }
        state = .ready; isWon = false; flagsPlaced = 0
    }
    func reveal(r: Int, c: Int) {
        guard !grid[r][c].isRevealed && !grid[r][c].isFlagged else { return }
        grid[r][c].isRevealed = true
        if grid[r][c].isMine { state = .gameOver }
    }
}
