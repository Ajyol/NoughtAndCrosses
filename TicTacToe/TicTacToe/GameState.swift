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
        // Vertical, horizontal, and diagonal victory checks
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

    func resetBoard() {
        board = Array(repeating: Array(repeating: Cell(tile: .Empty), count: 3), count: 3)
        turn = .Cross
    }
}
