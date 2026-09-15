import SwiftUI

struct RoomDetailView: View {
    let room: Room

    @Environment(FavoritesStore.self) private var store
    @State private var family: ColorFamily?

    private var colors: [PaintColor] {
        let base = ColorCatalog.colors(for: room)
        guard let family else { return base }
        return base.filter { $0.family == family }
    }

    private var availableFamilies: [ColorFamily] {
        let present = Set(ColorCatalog.colors(for: room).map(\.family))
        return ColorFamily.allCases.filter { present.contains($0) }
    }

    var body: some View {
        List {
            Section {
                InfoRow(symbol: "target", title: "حق شنو هذي الغرفة؟", text: room.goal)
                InfoRow(symbol: "lightbulb.max.fill", title: "نصيحة", text: room.tip)
            }

            if let chosen = store.chosenColor(for: room) {
                Section("لونك المعتمد") {
                    NavigationLink(value: chosen) {
                        ColorCard(color: chosen)
                    }
                }
            }

            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(title: "الكل", selected: family == nil) { family = nil }
                        ForEach(availableFamilies) { f in
                            FilterChip(title: f.title, selected: family == f) {
                                family = (family == f) ? nil : f
                            }
                        }
                    }
                    .padding(.vertical, 2)
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            Section("\(colors.count) لون يناسب \(room.title)") {
                ForEach(colors) { color in
                    NavigationLink(value: color) {
                        ColorCard(color: color)
                    }
                }
            }
        }
        .navigationTitle(room.title)
        .navigationDestination(for: PaintColor.self) { ColorDetailView(color: $0, room: room) }
    }
}

struct FilterChip: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.footnote.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .background(selected ? AnyShapeStyle(.tint) : AnyShapeStyle(.quaternary), in: Capsule())
                .foregroundStyle(selected ? Color.white : Color.primary)
        }
        .buttonStyle(.plain)
    }
}
