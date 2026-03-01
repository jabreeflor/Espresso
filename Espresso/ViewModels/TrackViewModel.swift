import Foundation
import SwiftData
import SwiftUI

@Observable
class TrackViewModel {
    var modelContext: ModelContext
    var todaysCaffeine: Int = 0
    var dailyLimit: Int = 400
    var todaysEntries: [CaffeineEntry] = []

    var ringProgress: Double {
        min(Double(todaysCaffeine) / Double(dailyLimit), 1.0)
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTodaysEntries()
    }

    func fetchTodaysEntries() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let predicate = #Predicate<CaffeineEntry> { entry in
            entry.loggedAt >= startOfDay
        }
        let descriptor = FetchDescriptor<CaffeineEntry>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.loggedAt, order: .reverse)]
        )

        do {
            todaysEntries = try modelContext.fetch(descriptor)
            todaysCaffeine = todaysEntries.reduce(0) { $0 + $1.caffeineMg }
        } catch {
            todaysEntries = []
            todaysCaffeine = 0
        }
    }

    func addDrink(_ drink: Drink) {
        let entry = CaffeineEntry(drinkName: drink.name, caffeineMg: drink.caffeineMg)
        modelContext.insert(entry)
        try? modelContext.save()
        fetchTodaysEntries()
    }

    func addCustomDrink(name: String, caffeineMg: Int) {
        guard caffeineMg > 0 else { return }
        let entry = CaffeineEntry(drinkName: name.isEmpty ? "Custom" : name, caffeineMg: caffeineMg)
        modelContext.insert(entry)
        try? modelContext.save()
        fetchTodaysEntries()
    }

    func undoLastEntry() {
        guard let last = todaysEntries.first else { return }
        modelContext.delete(last)
        try? modelContext.save()
        fetchTodaysEntries()
    }
}
