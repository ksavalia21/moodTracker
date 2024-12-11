import SwiftUI

struct ContentView: View {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var moodLogStore = MoodLogStore() // Shared log store

    var body: some View {
        TabView {
            // Mood Slider Page
            MoodSliderPage()
                .tabItem {
                    Label("Mood", systemImage: "face.smiling")
                }
                .environmentObject(moodLogStore) // Pass shared log store

            // Mood Logs Page
            MoodLogsPage()
                .tabItem {
                    Label("Logs", systemImage: "list.bullet")
                }
                .environmentObject(moodLogStore) // Pass shared log store
            
            AnalyticsDashboardPage()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.bar.xaxis")
                }
                .environmentObject(moodLogStore)
            
            SettingsPage()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .environmentObject(themeManager)
        }
        .environmentObject(themeManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
