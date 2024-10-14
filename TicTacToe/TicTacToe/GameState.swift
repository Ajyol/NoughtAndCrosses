
import Foundation

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtScore = 0
    @Published var crossScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"

    
    init()
    {
        resetBoard()
    }
    
    func placeTile(_ row: Int, _ column: Int)
    {
        if(board[row][column].tile != Tile.Empty)
        {
            return
        }
        
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if(checkVictory())
        {
            if(turn == Tile.Cross)
            {
                crossScore += 1
            }
            else
            {
                noughtScore += 1
            }
        }
        else
        {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross

        }
    }
    
    func checkVictory() -> Bool
    {
        return false
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2{
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
