import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var family: ColorFamily?

    private var results: [PaintColor] {
        let base = ColorCatalog.search(query)
        guard let family else { return base }
        return base.filter { $0.family == family }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            FilterChip(title: "الكل", selected: family == nil) { family = nil }
                            ForEach(ColorFamily.allCases) { f in
                                FilterChip(title: f.title, selected: family == f) {
                                    family = (family == f) ? nil : f
                                }
                            }
                        }
                        .padding(.vertical, 2)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }

                Section("\(results.count) لون") {
                    ForEach(results) { color in
                        NavigationLink(value: color) {
                            ColorCard(color: color)
                        }
                    }
                }
            }
            .searchable(text: $query, prompt: "ابحث باسم اللون أو المكان")
            .navigationTitle("كل الألوان")
            .navigationDestination(for: PaintColor.self) { ColorDetailView(color: $0, room: $0.rooms.first) }
            .overlay {
                if results.isEmpty {
                    ContentUnavailableView.search(text: query)
                }
            }
        }
    }
}
