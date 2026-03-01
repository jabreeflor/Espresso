import XCTest
import SwiftUI
@testable import Espresso

final class CaffeineTrendTests: XCTestCase {

    // MARK: - Given trend is up

    func testUpTrendSymbol() {
        // Given/When
        let trend = CaffeineTrend.up

        // Then
        XCTAssertEqual(trend.symbol, "arrow.up")
    }

    func testUpTrendColor() {
        // Given/When
        let trend = CaffeineTrend.up

        // Then
        XCTAssertEqual(trend.color, Color.green)
    }

    // MARK: - Given trend is down

    func testDownTrendSymbol() {
        // Given/When
        let trend = CaffeineTrend.down

        // Then
        XCTAssertEqual(trend.symbol, "arrow.down")
    }

    func testDownTrendColor() {
        // Given/When
        let trend = CaffeineTrend.down

        // Then
        XCTAssertEqual(trend.color, Color.red)
    }

    // MARK: - Given trend is neutral

    func testNeutralTrendSymbol() {
        // Given/When
        let trend = CaffeineTrend.neutral

        // Then
        XCTAssertEqual(trend.symbol, "minus")
    }

    func testNeutralTrendColor() {
        // Given/When
        let trend = CaffeineTrend.neutral

        // Then
        XCTAssertEqual(trend.color, Color.gray)
    }
}
