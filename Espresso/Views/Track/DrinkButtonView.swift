import SwiftUI

struct DrinkButtonView: View {
    let name: String
    let caffeineMg: Int
    let iconName: String
    let onTap: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(Color(red: 1, green: 0.97, blue: 0.88))
                        .frame(width: 70, height: 70)

                    Image(systemName: iconName)
                        .font(.system(size: 28))
                        .foregroundStyle(Color(red: 0.45, green: 0.3, blue: 0.2))
                }

                Text(name)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)

                Text("\(caffeineMg) mg")
                    .font(.caption2)
                    .foregroundStyle(Color(red: 1, green: 0.97, blue: 0.88))
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    DrinkButtonView(name: "Espresso", caffeineMg: 63, iconName: "cup.and.saucer.fill") {}
        .padding()
        .background(Color(red: 0.24, green: 0.15, blue: 0.14))
}
