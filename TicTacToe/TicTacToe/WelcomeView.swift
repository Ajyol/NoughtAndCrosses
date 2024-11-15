import SwiftUI

struct WelcomeView: View {
    @State private var isBotGame = false
    @State private var isGameStarted = false

    var body: some View {
        ZStack {
            // White background
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                // Simple Tic Tac Toe logo
                VStack(spacing: 4) {
                    HStack(spacing: 4) {
                        Rectangle()
                            .frame(width: 20, height: 60)
                            .foregroundColor(.black)
                        Rectangle()
                            .frame(width: 60, height: 20)
                            .foregroundColor(.black)
                    }
                    HStack(spacing: 4) {
                        Rectangle()
                            .frame(width: 60, height: 20)
                            .foregroundColor(.black)
                        Rectangle()
                            .frame(width: 20, height: 60)
                            .foregroundColor(.black)
                    }
                }
                
                Text("Tic Tac Toe")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                
                // Buttons with contrasting colors
                VStack(spacing: 20) {
                    Button(action: {
                        isBotGame = true
                        isGameStarted = true
                    }) {
                        Text("Play with Bot")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(15)
                    }

                    Button(action: {
                        isBotGame = false
                        isGameStarted = true
                    }) {
                        Text("Play with Another Player")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 40)
            }
            
            // Navigation link
            NavigationLink(
                destination: ContentView(isBotGame: isBotGame),
                isActive: $isGameStarted
            ) { EmptyView() }
        }
    }
}
