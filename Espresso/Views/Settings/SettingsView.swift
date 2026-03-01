import SwiftUI

struct SettingsView: View {
    @State private var viewModel = SettingsViewModel()

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

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Settings")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .padding(.top, 16)

                    // MARK: - Profile Section
                    sectionHeader("Profile")
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(creamColor)
                            .frame(width: 60, height: 60)

                        TextField("Username", text: $viewModel.username)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 0.28, green: 0.18, blue: 0.16))
                            )
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(cardColor)
                    )

                    // MARK: - Daily Limit Section
                    sectionHeader("Daily Limit")
                    VStack(spacing: 12) {
                        Text("\(Int(viewModel.dailyLimit)) mg")
                            .font(.title2.bold())
                            .foregroundStyle(.white)

                        Slider(
                            value: $viewModel.dailyLimit,
                            in: 100...800,
                            step: 25
                        )
                        .tint(creamColor)

                        HStack {
                            Text("100 mg")
                                .font(.caption)
                                .foregroundStyle(creamColor.opacity(0.6))
                            Spacer()
                            Text("800 mg")
                                .font(.caption)
                                .foregroundStyle(creamColor.opacity(0.6))
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(cardColor)
                    )

                    // MARK: - Notifications Section
                    sectionHeader("Notifications")
                    VStack {
                        Toggle("Enable Reminders", isOn: $viewModel.notificationsEnabled)
                            .foregroundStyle(.white)
                            .tint(creamColor)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(cardColor)
                    )

                    // MARK: - About Section
                    sectionHeader("About")
                    VStack(spacing: 14) {
                        HStack {
                            Text("Version")
                                .foregroundStyle(.white)
                            Spacer()
                            Text(viewModel.appVersion)
                                .foregroundStyle(creamColor.opacity(0.7))
                        }

                        Divider()
                            .overlay(creamColor.opacity(0.15))

                        Text("Made with \u{2615}")
                            .foregroundStyle(creamColor.opacity(0.7))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(cardColor)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.subheadline.smallCaps())
            .foregroundStyle(creamColor.opacity(0.7))
            .padding(.leading, 4)
    }
}

#Preview {
    SettingsView()
}
