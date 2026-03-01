import XCTest
@testable import Espresso

final class DrinkTests: XCTestCase {

    // MARK: - Given the default drink templates

    func testDefaultDrinksCount() {
        // Given/When
        let defaults = Drink.defaults

        // Then
        XCTAssertEqual(defaults.count, 3)
    }

    func testEspressoCaffeineValue() {
        // Given/When
        let espresso = Drink.espresso

        // Then
        XCTAssertEqual(espresso.name, "Espresso")
        XCTAssertEqual(espresso.caffeineMg, 63)
        XCTAssertTrue(espresso.isDefault)
    }

    func testDoubleEspressoCaffeineValue() {
        // Given/When
        let doubleEspresso = Drink.doubleEspresso

        // Then
        XCTAssertEqual(doubleEspresso.name, "Double Espresso")
        XCTAssertEqual(doubleEspresso.caffeineMg, 126)
        XCTAssertTrue(doubleEspresso.isDefault)
    }

    func testAmericanoCaffeineValue() {
        // Given/When
        let americano = Drink.americano

        // Then
        XCTAssertEqual(americano.name, "Americano")
        XCTAssertEqual(americano.caffeineMg, 95)
        XCTAssertTrue(americano.isDefault)
    }

    func testDrinkTemplateDefaults() {
        // Given/When - DrinkTemplate is defined in TrackView.swift
        let templates = DrinkTemplate.defaults

        // Then
        XCTAssertEqual(templates.count, 3)
        XCTAssertEqual(templates[0].name, "Espresso")
        XCTAssertEqual(templates[0].caffeineMg, 63)
        XCTAssertEqual(templates[1].name, "Double Espresso")
        XCTAssertEqual(templates[1].caffeineMg, 126)
        XCTAssertEqual(templates[2].name, "Americano")
        XCTAssertEqual(templates[2].caffeineMg, 95)
    }

    func testCustomDrinkCreation() {
        // Given
        let name = "Matcha Latte"
        let mg = 80

        // When
        let drink = Drink(name: name, caffeineMg: mg)

        // Then
        XCTAssertEqual(drink.name, "Matcha Latte")
        XCTAssertEqual(drink.caffeineMg, 80)
        XCTAssertFalse(drink.isDefault)
        XCTAssertEqual(drink.iconName, "cup.and.saucer.fill")
    }
}
