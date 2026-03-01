import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    private let cream = Color(red: 0.96, green: 0.93, blue: 0.85)
    private let darkBrown = Color(red: 0.24, green: 0.15, blue: 0.14)

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                TrackView()
                    .tag(0)
                LeaderboardView()
                    .tag(1)
                SettingsView()
                    .tag(2)
            }

            HStack(spacing: 0) {
                tabButton(icon: "clock", label: "Track", tag: 0)
                tabButton(icon: "person.2.fill", label: "Friends", tag: 1)
                tabButton(icon: "gearshape", label: "Settings", tag: 2)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(darkBrown)
        }
    }

    private func tabButton(icon: String, label: String, tag: Int) -> some View {
        Button {
            selectedTab = tag
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(label)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
            .foregroundStyle(selectedTab == tag ? cream : cream.opacity(0.4))
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [CaffeineEntry.self], inMemory: true)
}
