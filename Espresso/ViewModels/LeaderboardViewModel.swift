import Foundation
import SwiftUI

enum CaffeineTrend: String {
    case up, down, neutral

    var symbol: String {
        switch self {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .neutral: return "minus"
        }
    }

    var color: Color {
        switch self {
        case .up: return .green
        case .down: return .red
        case .neutral: return .gray
        }
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let caffeineMg: Int
    let trend: CaffeineTrend
    let avatarName: String
}

@Observable
class LeaderboardViewModel {
    var entries: [LeaderboardEntry] = [
        LeaderboardEntry(rank: 1, name: "Alex", caffeineMg: 450, trend: .up, avatarName: "person.circle.fill"),
        LeaderboardEntry(rank: 2, name: "Ben", caffeineMg: 300, trend: .neutral, avatarName: "person.circle.fill"),
        LeaderboardEntry(rank: 3, name: "Charlie", caffeineMg: 250, trend: .down, avatarName: "person.circle.fill"),
        LeaderboardEntry(rank: 4, name: "Diana", caffeineMg: 200, trend: .up, avatarName: "person.circle.fill"),
        LeaderboardEntry(rank: 5, name: "Eve", caffeineMg: 150, trend: .neutral, avatarName: "person.circle.fill")
    ]
}
