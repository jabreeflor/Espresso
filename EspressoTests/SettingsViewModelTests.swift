import XCTest
@testable import Espresso

final class SettingsViewModelTests: XCTestCase {

    var viewModel: SettingsViewModel!
    private let testSuiteName = "com.espresso.test.settings"

    override func setUp() {
        super.setUp()
        // Clean up test keys before each test
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "dailyLimit")
        UserDefaults.standard.removeObject(forKey: "notificationsEnabled")
        viewModel = SettingsViewModel()
    }

    override func tearDown() {
        // Clean up after tests
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "dailyLimit")
        UserDefaults.standard.removeObject(forKey: "notificationsEnabled")
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Given fresh app install (defaults)

    func testDefaultUsername() {
        // Given/When - fresh SettingsViewModel
        // Then
        XCTAssertEqual(viewModel.username, "Coffee Lover")
    }

    func testDefaultDailyLimit() {
        // Given/When - fresh SettingsViewModel
        // Then
        XCTAssertEqual(viewModel.dailyLimit, 400)
    }

    func testDefaultNotificationsDisabled() {
        // Given/When - fresh SettingsViewModel
        // Then
        XCTAssertFalse(viewModel.notificationsEnabled)
    }

    // MARK: - Given updated settings

    func testUsernamePeristsInUserDefaults() {
        // Given
        let newName = "Java Joe"

        // When
        viewModel.username = newName

        // Then
        XCTAssertEqual(UserDefaults.standard.string(forKey: "username"), "Java Joe")

        // And a new viewModel should read the persisted value
        let freshVM = SettingsViewModel()
        XCTAssertEqual(freshVM.username, "Java Joe")
    }

    func testDailyLimitPersists() {
        // Given
        let newLimit = 600.0

        // When
        viewModel.dailyLimit = newLimit

        // Then
        XCTAssertEqual(UserDefaults.standard.double(forKey: "dailyLimit"), 600.0)

        let freshVM = SettingsViewModel()
        XCTAssertEqual(freshVM.dailyLimit, 600.0)
    }

    func testNotificationsTogglePersists() {
        // Given/When
        viewModel.notificationsEnabled = true

        // Then
        XCTAssertTrue(UserDefaults.standard.bool(forKey: "notificationsEnabled"))

        let freshVM = SettingsViewModel()
        XCTAssertTrue(freshVM.notificationsEnabled)
    }

    func testDailyLimitZeroReturnsFourHundred() {
        // Given - explicitly set to 0 (the zero guard in getter)
        UserDefaults.standard.set(0.0, forKey: "dailyLimit")

        // When
        let freshVM = SettingsViewModel()

        // Then - should return 400 as default, not 0
        XCTAssertEqual(freshVM.dailyLimit, 400)
    }
}
