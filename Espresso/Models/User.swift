import Foundation
import SwiftData

@Model
final class User {
    var id: UUID
    var username: String
    var avatarURL: String?
    var dailyLimit: Int
    var createdAt: Date

    init(username: String, avatarURL: String? = nil, dailyLimit: Int = 400) {
        self.id = UUID()
        self.username = username
        self.avatarURL = avatarURL
        self.dailyLimit = dailyLimit
        self.createdAt = .now
    }
}
