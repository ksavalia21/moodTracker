import SwiftUI

class MoodLogStore: ObservableObject {
    
    @Published var moodLogs: [MoodLog] = [] {
        didSet {
            saveMoodLogs()
        }
    }
    
    private let logsKey = "MoodLogs" // Key for UserDefaults

        init() {
            loadMoodLogs()
            
            addSampleData()
        }

        // Save logs to UserDefaults
        private func saveMoodLogs() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(moodLogs) {
                UserDefaults.standard.set(encoded, forKey: logsKey)
            }
        }

        // Load logs from UserDefaults
        private func loadMoodLogs() {
            let decoder = JSONDecoder()
            if let savedLogs = UserDefaults.standard.data(forKey: logsKey),
               let decodedLogs = try? decoder.decode([MoodLog].self, from: savedLogs) {
                moodLogs = decodedLogs
            }
        }
    
        private func addSampleData() {
            let sampleData = [
                // Day 7 (7 days ago)
                MoodLog(mood: "happy", reason: "Enjoyed a delicious breakfast.", timestamp: Calendar.current.date(byAdding: .hour, value: -7 * 24 + 9, to: Date())!),
                MoodLog(mood: "sad", reason: "Had an argument with a friend.", timestamp: Calendar.current.date(byAdding: .hour, value: -7 * 24 + 13, to: Date())!),
                MoodLog(mood: "lovely", reason: "Watched a heartwarming movie.", timestamp: Calendar.current.date(byAdding: .hour, value: -7 * 24 + 20, to: Date())!),
                
                // Day 6 (6 days ago)
                MoodLog(mood: "overwhelmed", reason: "Work deadline was approaching.", timestamp: Calendar.current.date(byAdding: .hour, value: -6 * 24 + 10, to: Date())!),
                MoodLog(mood: "nothing", reason: "Spent the afternoon doing nothing.", timestamp: Calendar.current.date(byAdding: .hour, value: -6 * 24 + 15, to: Date())!),
                MoodLog(mood: "happy", reason: "Got some free time in the evening.", timestamp: Calendar.current.date(byAdding: .hour, value: -6 * 24 + 19, to: Date())!),
                
                // Day 5 (5 days ago)
                MoodLog(mood: "sad", reason: "Lost my wallet.", timestamp: Calendar.current.date(byAdding: .hour, value: -5 * 24 + 11, to: Date())!),
                MoodLog(mood: "happy", reason: "Someone returned my wallet!", timestamp: Calendar.current.date(byAdding: .hour, value: -5 * 24 + 14, to: Date())!),
                MoodLog(mood: "overwhelmed", reason: "Too many things to do in the evening.", timestamp: Calendar.current.date(byAdding: .hour, value: -5 * 24 + 20, to: Date())!),
                
                // Day 4 (4 days ago)
                MoodLog(mood: "lovely", reason: "Had a nice call with family.", timestamp: Calendar.current.date(byAdding: .hour, value: -4 * 24 + 9, to: Date())!),
                MoodLog(mood: "happy", reason: "Played video games with friends.", timestamp: Calendar.current.date(byAdding: .hour, value: -4 * 24 + 18, to: Date())!),
                
                // Day 3 (3 days ago)
                MoodLog(mood: "nothing", reason: "Just a regular morning.", timestamp: Calendar.current.date(byAdding: .hour, value: -3 * 24 + 8, to: Date())!),
                MoodLog(mood: "sad", reason: "Missed an important meeting.", timestamp: Calendar.current.date(byAdding: .hour, value: -3 * 24 + 14, to: Date())!),
                MoodLog(mood: "happy", reason: "Caught up with the meeting later.", timestamp: Calendar.current.date(byAdding: .hour, value: -3 * 24 + 16, to: Date())!),
                
                // Day 2 (2 days ago)
                MoodLog(mood: "overwhelmed", reason: "Had to multitask a lot in the morning.", timestamp: Calendar.current.date(byAdding: .hour, value: -2 * 24 + 10, to: Date())!),
                MoodLog(mood: "lovely", reason: "Went out for dinner with friends.", timestamp: Calendar.current.date(byAdding: .hour, value: -2 * 24 + 19, to: Date())!),
                
                // Day 1 (Yesterday)
                MoodLog(mood: "happy", reason: "Started the day with a great workout.", timestamp: Calendar.current.date(byAdding: .hour, value: -1 * 24 + 8, to: Date())!),
                MoodLog(mood: "nothing", reason: "Spent most of the afternoon reading.", timestamp: Calendar.current.date(byAdding: .hour, value: -1 * 24 + 14, to: Date())!),
                MoodLog(mood: "lovely", reason: "Watched a beautiful sunset.", timestamp: Calendar.current.date(byAdding: .hour, value: -1 * 24 + 18, to: Date())!),
                
                // Day 0 (Today)
                MoodLog(mood: "overwhelmed", reason: "Had to deal with unexpected issues at work.", timestamp: Calendar.current.date(byAdding: .hour, value: -6, to: Date())!),
                MoodLog(mood: "happy", reason: "Resolved all work issues successfully.", timestamp: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!)
            ]
                moodLogs.append(contentsOf: sampleData)
        }
}

struct MoodLog: Codable {
    var mood: String
    var reason: String
    var timestamp: Date
}

