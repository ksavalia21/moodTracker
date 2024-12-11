import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle(isOn: $themeManager.isDarkMode) {
                    Text("Dark Mode")
                }
                .onChange(of: themeManager.isDarkMode) { _ in
                    themeManager.saveThemePreference()
                }
            }
        }
        .navigationTitle("Settings")
    }
}

