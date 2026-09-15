import SwiftUI

@main
struct AlwanApp: App {
    @State private var store = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
