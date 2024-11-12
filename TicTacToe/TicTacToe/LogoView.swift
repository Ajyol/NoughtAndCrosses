import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .padding(.bottom, 10)
            
            ZStack {
                // Board background with rounded corners and shadow
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .frame(width: 120, height: 120)
                    .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 4)

                // Grid with three columns and rows for the "X" and "O"
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        CrossShape()
                        CircleShape()
                        CrossShape()
                    }
                    HStack(spacing: 10) {
                        CircleShape()
                        CrossShape()
                        CircleShape()
                    }
                    HStack(spacing: 10) {
                        CrossShape()
                        CircleShape()
                        CrossShape()
                    }
                }
            }
        }
    }
}

// Custom shapes for Cross and Circle
struct CrossShape: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 6, height: 30)
                .rotationEffect(.degrees(45))
            Rectangle()
                .fill(Color.blue)
                .frame(width: 6, height: 30)
                .rotationEffect(.degrees(-45))
        }
        .frame(width: 30, height: 30)
    }
}

struct CircleShape: View {
    var body: some View {
        Circle()
            .stroke(Color.red, lineWidth: 6)
            .frame(width: 30, height: 30)
    }
}

// Preview
struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
