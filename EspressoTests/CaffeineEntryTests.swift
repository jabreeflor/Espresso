import XCTest
import SwiftData
@testable import Espresso

final class CaffeineEntryTests: XCTestCase {

    // MARK: - Given a new CaffeineEntry

    func testEntryCreationWithProperties() throws {
        // Given
        let name = "Espresso"
        let mg = 63

        // When
        let entry = CaffeineEntry(drinkName: name, caffeineMg: mg)

        // Then
        XCTAssertEqual(entry.drinkName, "Espresso")
        XCTAssertEqual(entry.caffeineMg, 63)
        XCTAssertNotNil(entry.id)
    }

    func testEntryDefaultDate() throws {
        // Given/When
        let before = Date()
        let entry = CaffeineEntry(drinkName: "Test", caffeineMg: 100)
        let after = Date()

        // Then - loggedAt should be approximately now
        XCTAssertGreaterThanOrEqual(entry.loggedAt, before)
        XCTAssertLessThanOrEqual(entry.loggedAt, after)
    }

    func testEntryCustomDate() throws {
        // Given
        let customDate = Calendar.current.date(byAdding: .hour, value: -2, to: Date())!

        // When
        let entry = CaffeineEntry(drinkName: "Old Coffee", caffeineMg: 95, loggedAt: customDate)

        // Then
        XCTAssertEqual(entry.loggedAt, customDate)
    }

    func testEntryUniqueIds() throws {
        // Given/When
        let entry1 = CaffeineEntry(drinkName: "Coffee", caffeineMg: 100)
        let entry2 = CaffeineEntry(drinkName: "Coffee", caffeineMg: 100)

        // Then
        XCTAssertNotEqual(entry1.id, entry2.id)
    }
}
