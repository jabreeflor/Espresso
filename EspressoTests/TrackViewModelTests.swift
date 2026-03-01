import XCTest
import SwiftData
@testable import Espresso

final class TrackViewModelTests: XCTestCase {

    var container: ModelContainer!
    var context: ModelContext!
    var viewModel: TrackViewModel!

    override func setUp() {
        super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try! ModelContainer(for: CaffeineEntry.self, configurations: config)
        context = ModelContext(container)
        viewModel = TrackViewModel(modelContext: context)
    }

    override func tearDown() {
        viewModel = nil
        context = nil
        container = nil
        super.tearDown()
    }

    // MARK: - Given no entries today

    func testEmptyStateCaffeineIsZero() {
        // Given - fresh viewModel with no entries
        // When
        viewModel.fetchTodaysEntries()

        // Then
        XCTAssertEqual(viewModel.todaysCaffeine, 0)
        XCTAssertTrue(viewModel.todaysEntries.isEmpty)
    }

    func testEmptyStateRingProgressIsZero() {
        // Given - fresh viewModel with no entries
        // When/Then
        XCTAssertEqual(viewModel.ringProgress, 0.0)
    }

    // MARK: - Given adding a drink

    func testAddEspressoIncreasesCaffeine() {
        // Given
        let espresso = Drink.espresso

        // When
        viewModel.addDrink(espresso)

        // Then
        XCTAssertEqual(viewModel.todaysCaffeine, 63)
        XCTAssertEqual(viewModel.todaysEntries.count, 1)
    }

    func testAddMultipleDrinksCumulativeTotal() {
        // Given
        let espresso = Drink.espresso
        let americano = Drink.americano

        // When
        viewModel.addDrink(espresso)
        viewModel.addDrink(americano)

        // Then
        XCTAssertEqual(viewModel.todaysCaffeine, 158) // 63 + 95
        XCTAssertEqual(viewModel.todaysEntries.count, 2)
    }

    // MARK: - Given adding a custom drink

    func testAddCustomDrinkWithName() {
        // Given
        let name = "Matcha Latte"
        let mg = 80

        // When
        viewModel.addCustomDrink(name: name, caffeineMg: mg)

        // Then
        XCTAssertEqual(viewModel.todaysCaffeine, 80)
        XCTAssertEqual(viewModel.todaysEntries.first?.drinkName, "Matcha Latte")
    }

    func testAddCustomDrinkEmptyNameDefaultsToCustom() {
        // Given
        let name = ""
        let mg = 100

        // When
        viewModel.addCustomDrink(name: name, caffeineMg: mg)

        // Then
        XCTAssertEqual(viewModel.todaysEntries.first?.drinkName, "Custom")
    }

    func testAddCustomDrinkZeroMgGuard() {
        // Given
        let mg = 0

        // When
        viewModel.addCustomDrink(name: "Test", caffeineMg: mg)

        // Then - should not be added
        XCTAssertEqual(viewModel.todaysCaffeine, 0)
        XCTAssertTrue(viewModel.todaysEntries.isEmpty)
    }

    func testAddCustomDrinkNegativeMgGuard() {
        // Given
        let mg = -10

        // When
        viewModel.addCustomDrink(name: "Test", caffeineMg: mg)

        // Then - should not be added
        XCTAssertEqual(viewModel.todaysCaffeine, 0)
        XCTAssertTrue(viewModel.todaysEntries.isEmpty)
    }

    // MARK: - Given undo last entry

    func testUndoLastEntryRemovesIt() {
        // Given
        viewModel.addDrink(Drink.espresso)
        viewModel.addDrink(Drink.americano)
        XCTAssertEqual(viewModel.todaysCaffeine, 158)

        // When
        viewModel.undoLastEntry()

        // Then - the last entry (most recent) should be removed
        XCTAssertEqual(viewModel.todaysEntries.count, 1)
    }

    func testUndoOnEmptyDoesNothing() {
        // Given - no entries
        XCTAssertTrue(viewModel.todaysEntries.isEmpty)

        // When
        viewModel.undoLastEntry()

        // Then - still empty, no crash
        XCTAssertTrue(viewModel.todaysEntries.isEmpty)
    }

    // MARK: - Given ring progress

    func testRingProgressAtHalfLimit() {
        // Given - dailyLimit is 400
        viewModel.addCustomDrink(name: "Big Coffee", caffeineMg: 200)

        // When/Then
        XCTAssertEqual(viewModel.ringProgress, 0.5, accuracy: 0.01)
    }

    func testRingProgressCapsAtOne() {
        // Given - add more than 400mg
        viewModel.addCustomDrink(name: "Mega Coffee", caffeineMg: 500)

        // When/Then
        XCTAssertEqual(viewModel.ringProgress, 1.0)
    }

    func testRingProgressAtExactLimit() {
        // Given
        viewModel.addCustomDrink(name: "Exact", caffeineMg: 400)

        // When/Then
        XCTAssertEqual(viewModel.ringProgress, 1.0)
    }

    // MARK: - Given entries from yesterday

    func testYesterdaysEntriesNotIncluded() {
        // Given - insert an entry with yesterday's date directly
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let oldEntry = CaffeineEntry(drinkName: "Old Coffee", caffeineMg: 200, loggedAt: yesterday)
        context.insert(oldEntry)
        try? context.save()

        // When
        viewModel.fetchTodaysEntries()

        // Then - yesterday's entry should not count
        XCTAssertEqual(viewModel.todaysCaffeine, 0)
        XCTAssertTrue(viewModel.todaysEntries.isEmpty)
    }
}
