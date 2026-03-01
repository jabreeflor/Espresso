import SwiftUI

struct LeaderboardView: View {
    @State var viewModel = LeaderboardViewModel()
    @State private var showAddFriend = false

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
                HStack {
                    Text("Leaderboard")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)

                    Spacer()

                    Button {
                        showAddFriend = true
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .font(.title2)
                            .foregroundStyle(Color(red: 0.96, green: 0.93, blue: 0.85))
                    }
                }
                .padding(.horizontal)
                .padding(.top)

                if !viewModel.isCloudKitAvailable {
                    HStack(spacing: 6) {
                        Image(systemName: "icloud.slash")
                            .font(.caption)
                        Text("iCloud unavailable - showing sample data")
                            .font(.caption)
                    }
                    .foregroundStyle(Color(red: 0.96, green: 0.93, blue: 0.85).opacity(0.6))
                    .padding(.horizontal)
                }

                ScrollView {
                    if viewModel.isLoading {
                        VStack {
                            ProgressView()
                                .tint(Color(red: 0.96, green: 0.93, blue: 0.85))
                                .padding(.top, 40)
                            Text("Loading...")
                                .foregroundStyle(.white.opacity(0.6))
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(viewModel.entries) { entry in
                                LeaderboardCard(entry: entry)
                            }
                        }
                        .padding(.bottom)
                    }
                }
                .refreshable {
                    await viewModel.fetchLeaderboard()
                }
            }
        }
        .task {
            await viewModel.fetchLeaderboard()
        }
        .sheet(isPresented: $showAddFriend) {
            AddFriendSheet(viewModel: viewModel)
        }
    }
}

#Preview {
    LeaderboardView()
}
