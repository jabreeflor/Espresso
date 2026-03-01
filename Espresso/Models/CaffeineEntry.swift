import Foundation
import SwiftData

@Model
final class CaffeineEntry {
    var id: UUID
    var drinkName: String
    var caffeineMg: Int
    var loggedAt: Date

    init(drinkName: String, caffeineMg: Int, loggedAt: Date = .now) {
        self.id = UUID()
        self.drinkName = drinkName
        self.caffeineMg = caffeineMg
        self.loggedAt = loggedAt
    }
}
