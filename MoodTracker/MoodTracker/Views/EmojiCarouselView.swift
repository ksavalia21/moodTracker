import SwiftUI

struct EmojiCarouselView: View {
    @Binding var selectedEmoji: String
    let emojis = ["😊", "🥰", "😢", "😐", "😭", "🥹"]
    let action: (String) -> Void // Closure to trigger action

    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(emojis, id: \.self) { emoji in
                        Text(emoji)
                            .font(.system(size: 80))
                            .padding()
                            .onTapGesture {
                                selectedEmoji = emoji
                                action(emoji) // Call the action
                            }
                            .background(selectedEmoji == emoji ? Color.gray.opacity(0.2) : Color.clear)
                            .cornerRadius(16)
                            .shadow(radius: 10)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
