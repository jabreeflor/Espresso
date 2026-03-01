import SwiftUI
import SwiftData

struct TrackView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: TrackViewModel?

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.24, green: 0.15, blue: 0.14),
                    Color(red: 0.36, green: 0.25, blue: 0.22)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            if let vm = viewModel {
                VStack(spacing: 40) {
                    Spacer()

                    // Caffeine ring
                    CaffeineRingView(
                        caffeine: vm.todaysCaffeine,
                        dailyLimit: vm.dailyLimit,
                        progress: vm.ringProgress
                    )
                    .padding(.top, 20)

                    // Drink buttons
                    HStack(spacing: 30) {
                        ForEach(Drink.defaults, id: \.name) { drink in
                            DrinkButtonView(
                                name: drink.name,
                                caffeineMg: drink.caffeineMg,
                                iconName: drink.iconName
                            ) {
                                vm.addDrink(drink)
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = TrackViewModel(modelContext: modelContext)
            } else {
                viewModel?.fetchTodaysEntries()
            }
        }
    }
}

#Preview {
    TrackView()
        .modelContainer(for: [CaffeineEntry.self, Drink.self], inMemory: true)
}
