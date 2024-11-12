import Foundation

class GameState: ObservableObject {
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtScore = 0
    @Published var crossScore = 0
    @Published var showAlert = false
    @Published var alertMessage = ""

    init() {
        resetBoard()
    }

    func placeTile(_ row: Int, _ column: Int) {
        if board[row][column].tile != .Empty {
            return
        }

        board[row][column].tile = turn

        if checkVictory() {
            if turn == .Cross {
                crossScore += 1
            } else {
                noughtScore += 1
            }
            let winner = turn == .Cross ? "Crosses" : "Noughts"
            alertMessage = "\(winner) Win!"
            showAlert = true
        } else if isBoardFull() {
            alertMessage = "Draw!"
            showAlert = true
        } else {
            turn = turn == .Cross ? .Nought : .Cross
        }
    }

    func isBoardFull() -> Bool {
        return board.allSatisfy { row in
            row.allSatisfy { cell in
                cell.tile != .Empty
            }
        }
    }

    func checkVictory() -> Bool {
        let victoryConditions = [
            [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 1), (2, 1)], [(0, 2), (1, 2), (2, 2)], // vertical
            [(0, 0), (0, 1), (0, 2)], [(1, 0), (1, 1), (1, 2)], [(2, 0), (2, 1), (2, 2)], // horizontal
            [(0, 0), (1, 1), (2, 2)], [(0, 2), (1, 1), (2, 0)]  // diagonal
        ]

        return victoryConditions.contains { condition in
            condition.allSatisfy { (row, col) in board[row][col].tile == turn }
        }
    }

    func botMove() {
        // Try to block the player's winning move
        if let blockingMove = findBlockingMove(for: .Cross) {
            placeTile(blockingMove.0, blockingMove.1)
            return
        }
        
        // Otherwise, pick a random move
        var emptyCells = [(Int, Int)]()
        for row in 0..<3 {
            for column in 0..<3 {
                if board[row][column].tile == .Empty {
                    emptyCells.append((row, column))
                }
            }
        }
        
        if let randomMove = emptyCells.randomElement() {
            placeTile(randomMove.0, randomMove.1)
        }
    }

    // Helper function to find a blocking move for the specified tile
    private func findBlockingMove(for tile: Tile) -> (Int, Int)? {
        let victoryConditions = [
            [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 1), (2, 1)], [(0, 2), (1, 2), (2, 2)], // vertical
            [(0, 0), (0, 1), (0, 2)], [(1, 0), (1, 1), (1, 2)], [(2, 0), (2, 1), (2, 2)], // horizontal
            [(0, 0), (1, 1), (2, 2)], [(0, 2), (1, 1), (2, 0)]  // diagonal
        ]

        for condition in victoryConditions {
            let tiles = condition.map { (row, col) in board[row][col].tile }
            if tiles.filter({ $0 == tile }).count == 2 && tiles.contains(.Empty) {
                if let emptyIndex = tiles.firstIndex(of: .Empty) {
                    let (row, col) = condition[emptyIndex]
                    return (row, col)
                }
            }
        }
        return nil
    }

    func resetBoard() {
        board = Array(repeating: Array(repeating: Cell(tile: .Empty), count: 3), count: 3)
        turn = .Cross
    }
}
