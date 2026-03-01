import SwiftUI

struct LeaderboardView: View {
    @State var viewModel = LeaderboardViewModel()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.24, green: 0.15, blue: 0.14),
                    Color(red: 0.36, green: 0.25, blue: 0.22)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                Text("Leaderboard")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.entries) { entry in
                            LeaderboardCard(entry: entry)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    LeaderboardView()
}
