import SwiftUI

struct AccountSheetView: View {
    @Environment(SettingsStore.self) private var settings

    var isLoggedIn: Bool
    var titleText: String
    var accountImageUrl: String?
    var onDone: () -> Void
    var onLogin: () -> Void
    var onSettings: () -> Void
    var onSignOut: () -> Void

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 14) {
                        Image("StrofyLogo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 54, height: 54)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("STROFY")
                                .font(.title2.weight(.bold))
                            Text("تجربة موسيقية بلا حدود")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()
                    }
                    .padding(.vertical, 6)
                }

                Section {
                    Button(action: onSettings) {
                        HStack {
                            Label("الإعدادات", systemImage: "gearshape")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.tertiary)
                        }
                    }
                    .foregroundStyle(.primary)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("STROFY")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("تم") { onDone() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}
