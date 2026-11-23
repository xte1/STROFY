import SwiftUI

struct AccountButtonView: View {
    var isLoggedIn: Bool = false
    var accountImageUrl: String? = nil
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Image("StrofyLogo")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
