import Nuke
import SwiftUI

@main
struct TropApp: App {
    @State private var settings = SettingsStore.shared

    init() {
        UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        settings.contentCountry = "IQ"
        configureNuke()
        ensureDirectories()
        PlayerController.registerRemoteControlSupport()
        observePlaybackSettings()
        Task { await InnerTubeClient.tropShared.syncTropLocale() }
        Task { @MainActor in DiscordIntegration.shared.start() }
        Task { @MainActor in LastFMIntegration.shared.start() }
    }

    private func observePlaybackSettings() {
        func register() {
            withObservationTracking {
                let settings = SettingsStore.shared
                _ = settings.equalizerEnabled
                _ = settings.equalizerGains
                _ = settings.audioNormalization
                _ = settings.gaplessPlayback
            } onChange: {
                Task { @MainActor in
                    PlayerController.shared.applyPlaybackSettings()
                }
            }
        }
        register()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "ar"))
                .environment(\.layoutDirection, .rightToLeft)
                .preferredColorScheme(settings.preferredColorScheme)
                .tint(settings.accentColor)
                .environment(settings)
                .environment(\.downloadManager, DownloadManager.shared)
        }
    }

    private func configureNuke() {
        let dataCache = try? DataCache(name: "com.strofy.nuke")
        dataCache?.sizeLimit = 2 * 1024 * 1024 * 1024

        var config = ImagePipeline.Configuration()
        config.dataCache = dataCache
        config.imageCache = ImageCache(costLimit: 100 * 1024 * 1024)

        ImagePipeline.shared = ImagePipeline(configuration: config)
    }

    private func ensureDirectories() {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? FileManager.default.temporaryDirectory
        try? FileManager.default.createDirectory(at: docs.appendingPathComponent("Downloads"), withIntermediateDirectories: true)
        try? FileManager.default.createDirectory(at: docs.appendingPathComponent("Player"), withIntermediateDirectories: true)
    }
}
