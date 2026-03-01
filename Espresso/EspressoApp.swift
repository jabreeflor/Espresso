import SwiftUI
import SwiftData

@main
struct EspressoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [CaffeineEntry.self])
    }
}
