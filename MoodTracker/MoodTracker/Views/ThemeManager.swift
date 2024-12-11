import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    private func updateAppearance() {
        if isDarkMode {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
        }
    }

    init() {
        // Load saved preference from UserDefaults
        if let savedTheme = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool {
            isDarkMode = savedTheme
            updateAppearance()
        }
    }

    func saveThemePreference() {
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
}
