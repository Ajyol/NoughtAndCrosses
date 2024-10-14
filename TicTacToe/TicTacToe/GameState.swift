
import Foundation

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    
    init()
    {
        resetBoard()
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...cfragReservedCode_2{
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
