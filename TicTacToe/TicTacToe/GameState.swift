import Foundation
import SwiftUI

class GameState: ObservableObject {
    @Published var board: [[Cell]] = []
    @Published var turn: Tile = .Cross
    @Published var noughtScore: Int = 0
    @Published var crossScore: Int = 0
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var isBotGame: Bool = false

    init(isBotGame: Bool = false) {
        self.isBotGame = isBotGame
        resetBoard()
    }

    func placeTile(_ row: Int, _ column: Int) {
        guard board[row][column].tile == .Empty, !showAlert else { return }
        board[row][column].tile = turn

        if checkVictory() {
            handleVictory()
        } else if isBoardFull() {
            handleDraw()
        } else {
            switchTurn()

            if isBotGame && turn == .Nought {
                botMove()
            }
        }
    }

    private func switchTurn() {
        turn = (turn == .Cross) ? .Nought : .Cross
    }

    func botMove() {
        guard turn == .Nought else { return }

        if let winningMove = findBestMove(for: .Nought) {
            executeBotMove(winningMove)
            return
        }

        if let blockingMove = findBestMove(for: .Cross) {
            executeBotMove(blockingMove)
            return
        }

        if let randomMove = findRandomMove() {
            executeBotMove(randomMove)
        }
    }

    private func executeBotMove(_ move: (Int, Int)) {
        board[move.0][move.1].tile = turn

        if checkVictory() {
            handleVictory()
        } else if isBoardFull() {
            handleDraw()
        } else {
            switchTurn()
        }
    }

    private func findBestMove(for tile: Tile) -> (Int, Int)? {
        let victoryConditions = [
            [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 1), (2, 1)], [(0, 2), (1, 2), (2, 2)],
            [(0, 0), (0, 1), (0, 2)], [(1, 0), (1, 1), (1, 2)], [(2, 0), (2, 1), (2, 2)],
            [(0, 0), (1, 1), (2, 2)], [(0, 2), (1, 1), (2, 0)]
        ]

        for condition in victoryConditions {
            let tiles = condition.map { (row, col) in board[row][col].tile }
            if tiles.filter({ $0 == tile }).count == 2 && tiles.contains(.Empty) {
                if let emptyIndex = tiles.firstIndex(of: .Empty) {
                    return condition[emptyIndex]
                }
            }
        }
        return nil
    }

    private func findRandomMove() -> (Int, Int)? {
        var emptyCells = [(Int, Int)]()
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col].tile == .Empty {
                    emptyCells.append((row, col))
                }
            }
        }
        return emptyCells.randomElement()
    }

    private func isBoardFull() -> Bool {
        return board.allSatisfy { row in
            row.allSatisfy { cell in cell.tile != .Empty }
        }
    }

    private func checkVictory() -> Bool {
        let victoryConditions = [
            [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 1), (2, 1)], [(0, 2), (1, 2), (2, 2)],
            [(0, 0), (0, 1), (0, 2)], [(1, 0), (1, 1), (1, 2)], [(2, 0), (2, 1), (2, 2)],
            [(0, 0), (1, 1), (2, 2)], [(0, 2), (1, 1), (2, 0)]
        ]

        return victoryConditions.contains { condition in
            condition.allSatisfy { (row, col) in board[row][col].tile == turn }
        }
    }

    private func handleVictory() {
        if turn == .Cross {
            crossScore += 1
        } else {
            noughtScore += 1
        }
        let winner = turn == .Cross ? "Crosses" : "Noughts"
        alertMessage = "\(winner) Win!"
        showAlert = true
    }

    private func handleDraw() {
        alertMessage = "It's a Draw!"
        showAlert = true
    }

    func resetBoard() {
        board = Array(repeating: Array(repeating: Cell(tile: .Empty), count: 3), count: 3)
        turn = .Cross
        showAlert = false
        alertMessage = ""
    }
}
