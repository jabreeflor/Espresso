import SwiftUI

struct CaffeineRingView: View {
    var caffeine: Int
    var dailyLimit: Int
    var progress: Double

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(
                    Color(red: 0.4, green: 0.28, blue: 0.22).opacity(0.4),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )

            // Foreground arc
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.85, green: 0.75, blue: 0.6),
                            Color(red: 0.55, green: 0.35, blue: 0.2)
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.spring(), value: progress)

            // Center text
            VStack(spacing: 4) {
                Text("\(caffeine) mg")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(.white)

                Text("Daily Limit: \(dailyLimit) mg")
                    .font(.subheadline)
                    .foregroundStyle(Color(red: 1, green: 0.97, blue: 0.88))
            }
        }
        .frame(width: 250, height: 250)
    }
}

#Preview {
    CaffeineRingView(caffeine: 189, dailyLimit: 400, progress: 0.47)
        .padding()
        .background(Color(red: 0.24, green: 0.15, blue: 0.14))
}
