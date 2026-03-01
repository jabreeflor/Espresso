import XCTest
import SwiftUI
@testable import Espresso

final class LeaderboardViewModelTests: XCTestCase {

    var viewModel: LeaderboardViewModel!

    override func setUp() {
        super.setUp()
        viewModel = LeaderboardViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Given leaderboard initialized with mock data

    func testMockDataHasFiveEntries() {
        // Given/When - initialized viewModel
        // Then
        XCTAssertEqual(viewModel.entries.count, 5)
    }

    func testFirstPlaceIsAlex() {
        // Given/When
        let first = viewModel.entries.first

        // Then
        XCTAssertEqual(first?.name, "Alex")
        XCTAssertEqual(first?.rank, 1)
        XCTAssertEqual(first?.caffeineMg, 450)
    }

    func testEntriesAreRankedByDescendingCaffeine() {
        // Given/When
        let caffeineValues = viewModel.entries.map { $0.caffeineMg }

        // Then - should be descending
        XCTAssertEqual(caffeineValues, [450, 300, 250, 200, 150])
    }

    func testRanksAreSequential() {
        // Given/When
        let ranks = viewModel.entries.map { $0.rank }

        // Then
        XCTAssertEqual(ranks, [1, 2, 3, 4, 5])
    }

    func testLastPlaceIsEve() {
        // Given/When
        let last = viewModel.entries.last

        // Then
        XCTAssertEqual(last?.name, "Eve")
        XCTAssertEqual(last?.rank, 5)
        XCTAssertEqual(last?.caffeineMg, 150)
    }

    func testInitialLoadingState() {
        // Given/When - fresh viewModel
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testCloudKitInitiallyUnavailable() {
        // Given/When
        // Then
        XCTAssertFalse(viewModel.isCloudKitAvailable)
    }
}
