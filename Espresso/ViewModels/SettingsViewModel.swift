import Foundation
import SwiftUI

@Observable
class SettingsViewModel {
    var username: String {
        get { UserDefaults.standard.string(forKey: "username") ?? "Coffee Lover" }
        set { UserDefaults.standard.set(newValue, forKey: "username") }
    }

    var dailyLimit: Double {
        get { UserDefaults.standard.double(forKey: "dailyLimit").isZero ? 400 : UserDefaults.standard.double(forKey: "dailyLimit") }
        set { UserDefaults.standard.set(newValue, forKey: "dailyLimit") }
    }

    var notificationsEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "notificationsEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "notificationsEnabled") }
    }

    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
}
