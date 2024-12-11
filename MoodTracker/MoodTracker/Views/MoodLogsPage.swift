import SwiftUI

struct MoodLogsPage: View {
    @EnvironmentObject var moodLogStore: MoodLogStore // Access shared log store

    var body: some View {
        NavigationView {
            List {
                ForEach(moodLogStore.moodLogs.indices, id: \.self) { index in
                    let log = moodLogStore.moodLogs[index]
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Mood: \(log.mood.capitalized)")
                            .font(.headline)

                        Text("Reason: \(log.reason)")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text("Logged on: \(formattedDate(log.timestamp))")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: deleteLog) // Add delete functionality
            }
            .navigationTitle("Mood Logs")
            .toolbar {
                EditButton() // Enable editing mode
            }
        }
    }

    func deleteLog(at offsets: IndexSet) {
        moodLogStore.moodLogs.remove(atOffsets: offsets)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
