import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome Back! 🙏🏻")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text("What is your mood right now??🤡")
                .font(.system(size: 55))
                .fontWeight(.bold)
                .lineLimit(4)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(15)
    }
}
