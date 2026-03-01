import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TrackView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Track")
                }
                .tag(0)

            LeaderboardView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Friends")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(2)
        }
        .tint(Color("CreamAccent"))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [CaffeineEntry.self, Drink.self, User.self], inMemory: true)
}
