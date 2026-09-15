import SwiftUI

/// المفضلة + خطة ألوان البيت (اللون المعتمد لكل غرفة).
struct PlanView: View {
    @Environment(FavoritesStore.self) private var store

    var body: some View {
        NavigationStack {
            List {
                Section("خطة البيت") {
                    if store.plannedRooms.isEmpty {
                        Text("لم تعتمد أي لون بعد. افتح أي لون واضغط «اعتمده لهذه الغرفة».")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(store.plannedRooms, id: \.room) { entry in
                            NavigationLink(value: entry.color) {
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 9, style: .continuous)
                                        .fill(entry.color.color)
                                        .frame(width: 44, height: 44)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 9, style: .continuous)
                                                .strokeBorder(.primary.opacity(0.12), lineWidth: 1)
                                        )
                                    VStack(alignment: .leading, spacing: 2) {
                                        Label(entry.room.title, systemImage: entry.room.symbol)
                                            .font(.subheadline.weight(.semibold))
                                        Text("\(entry.color.name) · \(entry.color.id) · \(entry.color.finish.title)")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .swipeActions {
                                Button("حذف", role: .destructive) {
                                    store.clearChoice(for: entry.room)
                                }
                            }
                        }
                    }
                }

                Section("المفضلة") {
                    if store.favoriteColors.isEmpty {
                        Text("اضغط على القلب في صفحة أي لون ليظهر هنا.")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(store.favoriteColors) { color in
                            NavigationLink(value: color) {
                                ColorCard(color: color)
                            }
                            .swipeActions {
                                Button("إزالة", role: .destructive) {
                                    store.toggleFavorite(color)
                                }
                            }
                        }
                    }
                }

                if !store.plannedRooms.isEmpty {
                    Section("قائمة الشراء") {
                        Text(shoppingList)
                            .font(.system(.footnote, design: .monospaced))
                            .textSelection(.enabled)
                        ShareLink(item: shoppingList) {
                            Label("مشاركة القائمة مع محل الدهان", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
            .navigationTitle("خطتي")
            .navigationDestination(for: PaintColor.self) { ColorDetailView(color: $0, room: $0.rooms.first) }
        }
    }

    private var shoppingList: String {
        var lines = ["قائمة ألوان البيت:"]
        for entry in store.plannedRooms {
            lines.append("• \(entry.room.title): \(entry.color.name) — \(entry.color.id) — #\(entry.color.hex) — \(entry.color.finish.title)")
        }
        return lines.joined(separator: "\n")
    }
}
