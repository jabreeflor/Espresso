import SwiftUI
import SwiftData

struct DrinkTemplate: Identifiable {
    let id = UUID()
    let name: String
    let caffeineMg: Int
    let iconName: String

    static let defaults: [DrinkTemplate] = [
        DrinkTemplate(name: "Espresso", caffeineMg: 63, iconName: "cup.and.saucer.fill"),
        DrinkTemplate(name: "Double Espresso", caffeineMg: 126, iconName: "cup.and.saucer.fill"),
        DrinkTemplate(name: "Americano", caffeineMg: 95, iconName: "cup.and.saucer.fill")
    ]
}

struct TrackView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \CaffeineEntry.loggedAt, order: .reverse) private var allEntries: [CaffeineEntry]
    @State private var showCustomSheet = false

    private let dailyLimit = 400

    private var todaysEntries: [CaffeineEntry] {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        return allEntries.filter { $0.loggedAt >= startOfDay }
    }

    private var todaysCaffeine: Int {
        todaysEntries.reduce(0) { $0 + $1.caffeineMg }
    }

    private var ringProgress: Double {
        min(Double(todaysCaffeine) / Double(dailyLimit), 1.0)
    }

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

            VStack(spacing: 40) {
                Spacer()

                CaffeineRingView(
                    caffeine: todaysCaffeine,
                    dailyLimit: dailyLimit,
                    progress: ringProgress
                )
                .padding(.top, 20)

                HStack(spacing: 20) {
                    ForEach(DrinkTemplate.defaults) { drink in
                        DrinkButtonView(
                            name: drink.name,
                            caffeineMg: drink.caffeineMg,
                            iconName: drink.iconName
                        ) {
                            addEntry(name: drink.name, mg: drink.caffeineMg)
                        }
                    }

                    Button {
                        showCustomSheet = true
                    } label: {
                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 1, green: 0.97, blue: 0.88))
                                    .frame(width: 70, height: 70)
                                Image(systemName: "plus")
                                    .font(.system(size: 28, weight: .medium))
                                    .foregroundStyle(Color(red: 0.45, green: 0.3, blue: 0.2))
                            }
                            Text("Custom")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
                .sheet(isPresented: $showCustomSheet) {
                    CustomDrinkSheet { name, mg in
                        addEntry(name: name, mg: mg)
                    }
                }

                Spacer()
            }
            .padding()
        }
    }

    private func addEntry(name: String, mg: Int) {
        guard mg > 0 else { return }
        let entry = CaffeineEntry(drinkName: name.isEmpty ? "Custom" : name, caffeineMg: mg)
        modelContext.insert(entry)
        try? modelContext.save()
    }
}

#Preview {
    TrackView()
        .modelContainer(for: [CaffeineEntry.self], inMemory: true)
}
