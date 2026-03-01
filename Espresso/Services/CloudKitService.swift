import CloudKit
import SwiftUI

actor CloudKitService {
    static let shared = CloudKitService()

    private let container = CKContainer(identifier: "iCloud.com.espresso.app")
    private var database: CKDatabase { container.publicCloudDatabase }

    // Record Types
    enum RecordType: String {
        case user = "EspressoUser"
        case friendship = "Friendship"
    }

    // MARK: - Account Status
    func isAvailable() async -> Bool {
        do {
            let status = try await container.accountStatus()
            return status == .available
        } catch {
            return false
        }
    }

    // MARK: - User Management
    func fetchOrCreateCurrentUser(username: String) async throws -> CKRecord {
        let userRecordID = try await container.userRecordID()
        let predicate = NSPredicate(format: "userRecordID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)

        let (results, _) = try await database.records(matching: query)
        if let existing = results.first {
            return try existing.1.get()
        }

        // Create new user record
        let record = CKRecord(recordType: RecordType.user.rawValue)
        record["username"] = username
        record["dailyCaffeine"] = 0
        record["dailyLimit"] = 400
        record["lastUpdated"] = Date()
        record["userRecordID"] = CKRecord.Reference(recordID: userRecordID, action: .none)
        return try await database.save(record)
    }

    func syncCaffeine(amount: Int) async throws {
        let userRecordID = try await container.userRecordID()
        let predicate = NSPredicate(format: "userRecordID == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)

        let (results, _) = try await database.records(matching: query)
        if let existing = results.first {
            let record = try existing.1.get()
            record["dailyCaffeine"] = amount
            record["lastUpdated"] = Date()
            try await database.save(record)
        }
    }

    // MARK: - Leaderboard
    func fetchLeaderboard() async throws -> [LeaderboardEntry] {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "dailyCaffeine", ascending: false)]

        let (results, _) = try await database.records(matching: query, resultsLimit: 20)

        var entries: [LeaderboardEntry] = []
        for (index, result) in results.enumerated() {
            if let record = try? result.1.get() {
                let name = record["username"] as? String ?? "Unknown"
                let caffeine = record["dailyCaffeine"] as? Int ?? 0
                entries.append(LeaderboardEntry(
                    rank: index + 1,
                    name: name,
                    caffeineMg: caffeine,
                    trend: .neutral,
                    avatarName: "person.circle.fill"
                ))
            }
        }
        return entries
    }

    // MARK: - Friends
    func addFriend(username: String) async throws -> Bool {
        let predicate = NSPredicate(format: "username == %@", username)
        let query = CKQuery(recordType: RecordType.user.rawValue, predicate: predicate)

        let (results, _) = try await database.records(matching: query, resultsLimit: 1)
        guard let friendResult = results.first, let friendRecord = try? friendResult.1.get() else {
            return false
        }

        let userRecordID = try await container.userRecordID()
        let friendship = CKRecord(recordType: RecordType.friendship.rawValue)
        friendship["userRef"] = CKRecord.Reference(recordID: userRecordID, action: .none)
        friendship["friendRef"] = CKRecord.Reference(recordID: friendRecord.recordID, action: .none)
        friendship["status"] = "accepted"
        try await database.save(friendship)
        return true
    }
}
