import Combine
import SwiftUI

struct ContentView: View {
    @Environment(SettingsStore.self) private var settings
    @State private var nowPlaying = NowPlaying.shared
    @State private var selectedTab = SettingsStore.shared.defaultTab
    @State private var isExpanded = false
    @State private var scrollState = MiniPlayerScrollState()

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("الرئيسية", systemImage: "music.note.house.fill", value: 0) {
                HomeScreenView()
            }

            Tab("المكتبة", systemImage: "music.note.square.stack", value: 1) {
                LibraryView()
            }

            Tab("استكشاف", systemImage: "flame", value: 2) {
                ExploreView()
            }

            Tab("بحث", systemImage: "magnifyingglass", value: 3, role: .search) {
                SearchView()
            }

            Tab("الإعدادات", systemImage: "gearshape.fill", value: 4) {
                SettingsScreenView()
            }
        }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewBottomAccessory(isEnabled: nowPlaying.isBarPresented) {
            MiniPlayerBarView(onExpand: {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    isExpanded = true
                }
            })
        }
        .background {
            backgroundLayer
        }
        .overlay {
            if isExpanded {
                FullPlayerView(onCollapse: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                        isExpanded = false
                    }
                })
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .environment(scrollState)
        .onAppear { AppRouter.shared.selectedTabIndex = selectedTab }
        .onChange(of: selectedTab) { _, newValue in
            AppRouter.shared.selectedTabIndex = newValue
        }
        .onReceive(AppRouter.shared.$activeRoute) { route in
            if route != nil {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                    isExpanded = false
                }
            }
        }
        .onReceive(AppRouter.shared.$playerExpandToken.dropFirst()) { _ in
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                isExpanded = true
            }
        }
        .simultaneousGesture(backSwipeGesture)
    }

    private var backSwipeGesture: some Gesture {
        DragGesture(minimumDistance: 20)
            .onEnded { value in
                let isHorizontal = abs(value.translation.width) > abs(value.translation.height)
                guard !isExpanded,
                      isHorizontal,
                      abs(value.translation.width) > 80 else { return }

                let router = AppRouter.shared
                let depth = router.activePathDepth
                guard depth > 0 else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    guard !isExpanded, router.activePathDepth == depth else { return }
                    router.popActiveRoute()
                }
            }
    }

    @ViewBuilder
    private var backgroundLayer: some View {
        Color(.systemBackground).ignoresSafeArea()
    }
}
