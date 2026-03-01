import SwiftUI

struct CustomDrinkSheet: View {
    var onAdd: (String, Int) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var drinkName: String = ""
    @State private var caffeineAmount: String = ""

    private var isValid: Bool {
        guard let amount = Int(caffeineAmount) else { return false }
        return amount > 0
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Add Custom Drink")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 24)

            TextField("Drink name", text: $drinkName)
                .foregroundStyle(.white)
                .padding(14)
                .background(Color(red: 0.28, green: 0.18, blue: 0.16))
                .cornerRadius(12)

            TextField("Caffeine (mg)", text: $caffeineAmount)
                .keyboardType(.numberPad)
                .foregroundStyle(.white)
                .padding(14)
                .background(Color(red: 0.28, green: 0.18, blue: 0.16))
                .cornerRadius(12)

            Button {
                if let mg = Int(caffeineAmount) {
                    onAdd(drinkName, mg)
                    dismiss()
                }
            } label: {
                Text("Add")
                    .fontWeight(.bold)
                    .foregroundStyle(Color(red: 0.24, green: 0.15, blue: 0.14))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0.96, green: 0.93, blue: 0.85))
                    .cornerRadius(14)
            }
            .disabled(!isValid)
            .opacity(isValid ? 1.0 : 0.5)

            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .foregroundStyle(Color(red: 0.96, green: 0.93, blue: 0.85))
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 0.24, green: 0.15, blue: 0.14),
                    Color(red: 0.36, green: 0.25, blue: 0.22)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .presentationDetents([.medium])
        .presentationBackground(.clear)
    }
}

#Preview {
    CustomDrinkSheet { name, mg in
        print("\(name): \(mg)mg")
    }
}
