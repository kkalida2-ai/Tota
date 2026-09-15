import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("الغرف", systemImage: "house.fill") {
                RoomsGridView()
            }
            Tab("الألوان", systemImage: "paintpalette.fill") {
                SearchView()
            }
            Tab("خطتي", systemImage: "checkmark.seal.fill") {
                PlanView()
            }
        }
    }
}
