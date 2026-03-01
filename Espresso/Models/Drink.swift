import Foundation

struct Drink: Identifiable {
    let id: UUID
    let name: String
    let caffeineMg: Int
    let iconName: String
    let isDefault: Bool

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
