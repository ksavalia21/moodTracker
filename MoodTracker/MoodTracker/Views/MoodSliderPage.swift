import SwiftUI

struct MoodSliderPage: View {
    @EnvironmentObject var moodLogStore: MoodLogStore
    @EnvironmentObject var themeManager: ThemeManager
    @State private var moodValue: Double = 1
    @State private var moodLabel: String = "happy"
    @State private var emoji: String = "😊"
    @State private var emojiColor: Color = .yellow
    @State private var moodReason: String = ""
    let emojis = ["😊", "🥰", "😢", "😐", "😭", "🥹"]

    var body: some View {
        VStack {
            
            HeaderView()
            
            EmojiCarouselView(selectedEmoji: $emoji) { selectedEmoji in
                updateMood(fromEmoji: selectedEmoji)
            }
            
            VStack {
                Text(emoji)
                    .font(.system(size: 80))
                    .foregroundColor(emojiColor)

                Text("I'm feeling \(moodLabel)")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .foregroundColor(themeManager.isDarkMode ? .white : .black)
            }
            .padding(.vertical)

            TextField("Enter the reason behind your mood...", text: $moodReason)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.vertical)
                .frame(height:50)
                .background(themeManager.isDarkMode ? Color.gray.opacity(0.2) : Color.white)
                .cornerRadius(8)

            Button(action: {
                saveMoodLog(mood: moodLabel, reason: moodReason)
            }) {
                Text("SAVE")
                    .fontWeight(.bold)
                    .foregroundColor(themeManager.isDarkMode ? .black : .white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(themeManager.isDarkMode ? Color.white : Color.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }


    func updateMood(fromEmoji emoji: String) {
        switch emoji {
        case "😊":
            moodLabel = "happy"
            emojiColor = .green
        case "🥰":
            moodLabel = "lovely"
            emojiColor = .pink
        case "😢":
            moodLabel = "sad"
            emojiColor = .red
        case "😐":
            moodLabel = "nothing"
            emojiColor = .yellow
        case "😭":
            moodLabel = "very sad"
            emojiColor = .gray
        case "🥹":
            moodLabel = "overwhelmed"
            emojiColor = .orange
        default:
            break // Handle unexpected emojis if needed
        }
    }

    func saveMoodLog(mood: String, reason: String) {
        guard !reason.isEmpty else { return }
        let timestamp = Date()
        let newLog = MoodLog(mood: mood, reason: reason, timestamp: timestamp)
        moodLogStore.moodLogs.append(newLog) // Save the log
        moodReason = "" // Clear the reason field
        print("Mood Saved: \(mood), Reason: \(reason), Timestamp: \(timestamp)")
    }
}

