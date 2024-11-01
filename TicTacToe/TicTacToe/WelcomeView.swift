import SwiftUI

struct WelcomeView: View {
    @State private var isBotGame = false
    @State private var isGameStarted = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Tic Tac Toe!")
                .font(.largeTitle)
                .padding()

            Button("Play with Bot") {
                isBotGame = true
                isGameStarted = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Button("Play with Another Player") {
                isBotGame = false
                isGameStarted = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            NavigationLink(
                destination: ContentView(isBotGame: isBotGame),
                isActive: $isGameStarted
            ) { EmptyView() }
        }
    }
}
