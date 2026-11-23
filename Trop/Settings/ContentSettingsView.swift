import SwiftUI

struct ContentSettingsView: View {
    @Environment(\.settingsStore) private var settings

    var body: some View {
        @Bindable var settings = settings

        List {
            Section {
                SettingsToggleRow("إخفاء المحتوى غير اللائق", icon: "eye.slash", isOn: $settings.hideExplicit)
            } header: {
                Text("تصفية المحتوى")
            }

            Section {
                SettingsToggleRow("إظهار الاختيارات السريعة", icon: "sparkles", isOn: $settings.showQuickPicks)
                Stepper(value: $settings.topListsLength, in: 4...20, step: 2) {
                    Label("طول القوائم الأعلى: \(settings.topListsLength)", systemImage: "list.number")
                }
            } header: {
                Text("الصفحة الرئيسية")
            }

            Section {
                SettingsToggleRow("حفظ سجل البحث", icon: "magnifyingglass", isOn: $settings.trackSearchHistory)
                SettingsToggleRow("حفظ سجل التشغيل", icon: "clock.arrow.circlepath", isOn: $settings.trackPlayHistory)
            } header: {
                Text("الخصوصية")
            } footer: {
                Text("عند الإيقاف، لن يتم تسجيل عمليات البحث أو التشغيل محلياً.")
            }

            Section {
                SettingsToggleRow("مزامنة الفنانين", icon: "music.mic", isOn: $settings.syncArtists)
                SettingsToggleRow("مزامنة قوائم التشغيل", icon: "music.note.list", isOn: $settings.syncPlaylists)
                SettingsToggleRow("مزامنة الألبومات", icon: "square.stack", isOn: $settings.syncAlbums)
                SettingsToggleRow("مزامنة البودكاست", icon: "antenna.radiowaves.left.and.right", isOn: $settings.syncPodcasts)
                SettingsToggleRow("مزامنة الأغاني المعجب بها", icon: "heart.fill", isOn: $settings.syncSongs)
            } header: {
                Text("مزامنة المكتبة")
            }
        }
        .onAppear {
            settings.contentCountry = "IQ"
        }
        .navigationTitle("المحتوى")
        .navigationBarTitleDisplayMode(.inline)
        .miniPlayerTracksScroll()
    }
}
