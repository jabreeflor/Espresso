import Foundation
import SwiftData

@Model
final class Drink {
    var id: UUID
    var name: String
    var caffeineMg: Int
    var iconName: String
    var isDefault: Bool

    init(name: String, caffeineMg: Int, iconName: String = "cup.and.saucer.fill", isDefault: Bool = false) {
        self.id = UUID()
        self.name = name
        self.caffeineMg = caffeineMg
        self.iconName = iconName
        self.isDefault = isDefault
    }

    static let espresso = Drink(name: "Espresso", caffeineMg: 63, iconName: "cup.and.saucer.fill", isDefault: true)
    static let doubleEspresso = Drink(name: "Double Espresso", caffeineMg: 126, iconName: "cup.and.saucer.fill", isDefault: true)
    static let americano = Drink(name: "Americano", caffeineMg: 95, iconName: "cup.and.saucer.fill", isDefault: true)

    static let defaults: [Drink] = [espresso, doubleEspresso, americano]
}
