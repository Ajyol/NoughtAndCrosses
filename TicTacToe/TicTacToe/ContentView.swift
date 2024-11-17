import SwiftUI

struct ContentView: View {
    
    @StateObject var gameState = GameState()
    var isBotGame: Bool
    
    var body: some View {
        let borderSize = CGFloat(5)
        VStack {
            // Scoreboard
            HStack {
                VStack {
                    Text("Crosses")
                        .font(.headline)
                    Text("\(gameState.crossScore)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black) // Crosses score in black
                }
                Spacer()
                VStack {
                    Text("Noughts")
                        .font(.headline)
                    Text("\(gameState.noughtScore)")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red) // Noughts score in red
                }
            }
            .padding()
            
            Spacer()
            
            // Game Board
            VStack(spacing: borderSize) {
                ForEach(0...2, id: \.self) { row in
                    HStack(spacing: borderSize) {
                        ForEach(0...2, id: \.self) { column in
                            let cell = gameState.board[row][column]
                            
                            Text(cell.displayTile())
                                .font(.system(size: 60))
                                .foregroundColor(cell.tileColor())
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .background(Color.white)
                                .onTapGesture {
                                    if cell.tile == .Empty {
                                        gameState.placeTile(row, column)
                                        
                                        if isBotGame && !gameState.showAlert {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                gameState.botMove()
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .background(Color.black)
            .padding()
            
            Spacer()
        }
        .alert(isPresented: $gameState.showAlert) {
            Alert(title: Text(gameState.alertMessage), dismissButton: .default(Text("Okay")) {
                gameState.resetBoard()
            })
        }
    }
}

#Preview {
    ContentView(isBotGame: false)
}
