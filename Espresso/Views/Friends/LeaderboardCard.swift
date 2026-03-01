import SwiftUI

struct LeaderboardCard: View {
    let entry: LeaderboardEntry

    var body: some View {
        HStack(spacing: 16) {
            // Avatar
            ZStack(alignment: .topTrailing) {
                Image(systemName: entry.avatarName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color(red: 1, green: 0.97, blue: 0.88))
                    .frame(width: 50, height: 50)

                if entry.rank == 1 {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(.yellow)
                        .offset(x: 4, y: -4)
                }
            }

            // Name and caffeine
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.name)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("\(entry.caffeineMg) mg")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }

            Spacer()

            // Trend arrow
            Image(systemName: entry.trend.symbol)
                .font(.title3.bold())
                .foregroundStyle(entry.trend.color)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.55, green: 0.40, blue: 0.30),
                            Color(red: 0.45, green: 0.30, blue: 0.20)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 4)
        )
        .padding(.horizontal)
    }
}

#Preview {
    LeaderboardCard(
        entry: LeaderboardEntry(rank: 1, name: "Alex", caffeineMg: 450, trend: .up, avatarName: "person.circle.fill")
    )
    .padding()
    .background(Color(red: 0.24, green: 0.15, blue: 0.14))
}
