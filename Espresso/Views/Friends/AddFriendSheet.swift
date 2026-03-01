import SwiftUI

struct AddFriendSheet: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: LeaderboardViewModel

    @State private var username = ""
    @State private var isSearching = false
    @State private var resultMessage: String?
    @State private var isSuccess = false

    private let cardColor = Color(red: 0.35, green: 0.24, blue: 0.20)
    private let creamColor = Color(red: 0.96, green: 0.93, blue: 0.85)

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.24, green: 0.15, blue: 0.14),
                    Color(red: 0.36, green: 0.25, blue: 0.22)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                // Header
                HStack {
                    Text("Add Friend")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(creamColor.opacity(0.6))
                    }
                }
                .padding(.top, 20)

                // Search field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.subheadline)
                        .foregroundStyle(creamColor.opacity(0.7))

                    TextField("Enter username", text: $username)
                        .foregroundStyle(.white)
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.28, green: 0.18, blue: 0.16))
                        )
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }

                // Result message
                if let message = resultMessage {
                    HStack(spacing: 8) {
                        Image(systemName: isSuccess ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                        Text(message)
                    }
                    .font(.subheadline)
                    .foregroundStyle(isSuccess ? .green : .red)
                }

                // Add button
                Button {
                    Task {
                        isSearching = true
                        resultMessage = nil
                        let success = await viewModel.addFriend(username: username)
                        isSuccess = success
                        resultMessage = success ? "Friend added!" : "User not found"
                        isSearching = false
                        if success {
                            try? await Task.sleep(for: .seconds(1))
                            dismiss()
                        }
                    }
                } label: {
                    Group {
                        if isSearching {
                            ProgressView()
                                .tint(Color(red: 0.35, green: 0.24, blue: 0.20))
                        } else {
                            Text("Add Friend")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(creamColor)
                    .foregroundStyle(Color(red: 0.35, green: 0.24, blue: 0.20))
                    .cornerRadius(14)
                }
                .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty || isSearching)
                .opacity(username.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1)

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    AddFriendSheet(viewModel: LeaderboardViewModel())
}
