import SwiftUI
import Charts

struct AnalyticsDashboardPage: View {
    @EnvironmentObject var moodLogStore: MoodLogStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Mood Analytics")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)

                    Divider()

                    // Mood Trends Over Time
                    Text("Mood Trends Over Time")
                        .font(.headline)
                        .padding(.horizontal)

                    // Map MoodLogs to the required tuple format
                    LineChartView(moodLogs: moodLogStore.moodLogs.map {
                        (mood: $0.mood, reason: $0.reason, timestamp: $0.timestamp)
                    })
                        .frame(height: 200)
                        .padding(.horizontal)

                    // Most Common Mood
                    Text("Most Common Mood")
                        .font(.headline)
                        .padding(.horizontal)

                    // Map MoodLogs to the required tuple format
                    PieChartView(moodLogs: moodLogStore.moodLogs.map {
                        (mood: $0.mood, reason: $0.reason, timestamp: $0.timestamp)
                    })
                        .frame(height: 200)
                        .padding(.horizontal)

                    // Mood Breakdown Summary
                    Text("Mood Breakdown")
                        .font(.headline)
                        .padding(.horizontal)

                    MoodBreakdownSummary(moodLogs: moodLogStore.moodLogs.map {
                        (mood: $0.mood, reason: $0.reason, timestamp: $0.timestamp)
                    })
                        .padding(.horizontal)

                    Divider()

                    // Recent Mood Logs
                    Text("Recent Logs")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(moodLogStore.moodLogs.prefix(5), id: \.timestamp) { log in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(log.mood)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(log.timestamp, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Text(log.reason)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
}


struct LineChartView: View {
    let moodLogs: [(mood: String, reason: String, timestamp: Date)]
    
    var data: [MoodData] {
        let groupedLogs = Dictionary(grouping: moodLogs) { log in
            Calendar.current.startOfDay(for: log.timestamp)
        }
        return groupedLogs.map { date, logs in
            MoodData(date: date, count: logs.count)
        }
        .sorted { $0.date < $1.date }
    }

    var body: some View {
        Chart(data) {
            LineMark(
                x: .value("Date", $0.date, unit: .day),
                y: .value("Count", $0.count)
            )
            .symbol(.circle)
            .foregroundStyle(.blue)
        }
    }
}

struct MoodData: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}

struct PieChartView: View {
    let moodLogs: [(mood: String, reason: String, timestamp: Date)]

    var moodCounts: [MoodCount] {
        let groupedMoods = Dictionary(grouping: moodLogs) { $0.mood }
        return groupedMoods.map { mood, logs in
            MoodCount(mood: mood, count: logs.count)
        }
    }

    var body: some View {
        Chart(moodCounts) {
            SectorMark(
                angle: .value("Mood", $0.count),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(by: .value("Mood", $0.mood))
        }
    }
}

struct MoodCount: Identifiable {
    let id = UUID()
    let mood: String
    let count: Int
}

struct MoodBreakdownSummary: View {
    let moodLogs: [(mood: String, reason: String, timestamp: Date)]

    var moodCounts: [MoodCount] {
        let groupedMoods = Dictionary(grouping: moodLogs) { $0.mood }
        return groupedMoods.map { mood, logs in
            MoodCount(mood: mood, count: logs.count)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(moodCounts) { mood in
                HStack {
                    Text("\(mood.mood.capitalized):")
                        .font(.headline)
                    Spacer()
                    Text("\(mood.count) logs")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
