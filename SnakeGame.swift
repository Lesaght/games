import SwiftUI
import Observation

enum Direction {
    case up, down, left, right
    var isOpposite: (Direction) -> Bool {
        switch self {
        case .up: return { $0 == .down }; case .down: return { $0 == .up }
        case .left: return { $0 == .right }; case .right: return { $0 == .left }
        }
    }
}

struct Point: Hashable { var x: Int; var y: Int }
enum GameState { case ready, playing, gameOver }

@Observable
final class SnakeGame {
    let columns = 20; let rows = 28
    private(set) var snake: [Point] = []; private(set) var food = Point(x: 0, y: 0)
    private(set) var direction: Direction = .right; private(set) var score = 0
    private(set) var bestScore = UserDefaults.standard.integer(forKey: "BestScore")
    private(set) var state: GameState = .ready
    private var pendingDirection: Direction?; private var timer: Timer?

    init() { reset() }
    func start() {
        reset(); state = .playing
        timer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { [weak self] _ in self?.tick() }
    }
    func stop() { timer?.invalidate(); timer = nil }
    func reset() {
        stop(); snake = [Point(x: columns/2, y: rows/2), Point(x: columns/2-1, y: rows/2), Point(x: columns/2-2, y: rows/2)]
        direction = .right; pendingDirection = nil; score = 0; state = .ready; spawnFood()
    }
    func changeDirection(_ new: Direction) { if !direction.isOpposite(new) { pendingDirection = new } }
    private func tick() {
        if let pending = pendingDirection { direction = pending; pendingDirection = nil }
        guard let head = snake.first else { return }
        let newHead = Point(x: head.x + (direction == .left ? -1 : direction == .right ? 1 : 0),
                            y: head.y + (direction == .up ? -1 : direction == .down ? 1 : 0))
        if newHead.x < 0 || newHead.x >= columns || newHead.y < 0 || newHead.y >= rows || snake.contains(newHead) { gameOver(); return }
        snake.insert(newHead, at: 0)
        if newHead == food { score += 10; spawnFood() } else { snake.removeLast() }
    }
    private func gameOver() { stop(); state = .gameOver; if score > bestScore { bestScore = score; UserDefaults.standard.set(bestScore, forKey: "BestScore") } }
    private func spawnFood() { repeat { food = Point(x: Int.random(in: 0..<columns), y: Int.random(in: 0..<rows)) } while snake.contains(food) }
}
