import SwiftUI

struct ColorDetailView: View {
    let color: PaintColor
    var room: Room?

    @Environment(FavoritesStore.self) private var store
    @State private var lighting: PreviewLighting = .day

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // اللون بحجم كبير + معاينة الغرفة
                VStack(spacing: 10) {
                    RoomPreview(
                        color: color,
                        room: room ?? color.rooms.first ?? .living,
                        lighting: lighting,
                        height: 250
                    )
                    Picker("الإضاءة", selection: $lighting) {
                        ForEach(PreviewLighting.allCases) { Text($0.title).tag($0) }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(color.name).font(.largeTitle.bold())
                        Spacer()
                        Text("#\(color.hex)")
                            .font(.system(.footnote, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                    Text("\(color.id) · \(color.family.title)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal)

                // حق شنو / وين استخدمه
                VStack(alignment: .leading, spacing: 14) {
                    InfoRow(symbol: "sparkles", title: "حق شنو؟", text: color.purpose)
                    Divider()
                    InfoRow(symbol: "mappin.and.ellipse", title: "وين استخدمه؟", text: color.usage)
                    Divider()
                    InfoRow(symbol: "lightbulb.fill", title: "مع الإضاءة", text: color.lighting)
                    Divider()
                    InfoRow(
                        symbol: "paintbrush.pointed.fill",
                        title: "نوع الدهان المقترح: \(color.finish.title)",
                        text: color.finish.note
                    )
                }
                .padding()
                .background(.background.secondary, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.horizontal)

                // الألوان المنسجمة
                VStack(alignment: .leading, spacing: 10) {
                    Text("ينسجم مع")
                        .font(.headline)
                    PairStrip(hexes: color.pairs)
                    Text("استخدم هذه في الأثاث والستائر والتفاصيل، لا على الجدار نفسه.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.background.secondary, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.horizontal)

                // الغرف المناسبة
                VStack(alignment: .leading, spacing: 10) {
                    Text("يناسب هذه الأماكن")
                        .font(.headline)
                    FlowRooms(rooms: color.rooms)
                }
                .padding()
                .background(.background.secondary, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.horizontal)

                // اختيار اللون لهذه الغرفة
                if let room {
                    Button {
                        if store.isChosen(color, for: room) {
                            store.clearChoice(for: room)
                        } else {
                            store.choose(color, for: room)
                        }
                    } label: {
                        Label(
                            store.isChosen(color, for: room)
                                ? "هذا لون \(room.title) — اضغط للإلغاء"
                                : "اعتمده لـ \(room.title)",
                            systemImage: store.isChosen(color, for: room) ? "checkmark.seal.fill" : "house.fill"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.horizontal)
                }

                Spacer(minLength: 24)
            }
            .padding(.top, 8)
        }
        .navigationTitle(color.name)
        .navigationBarTitleDisplayMode(.inline)
        .tint(color.color)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.toggleFavorite(color)
                } label: {
                    Image(systemName: store.isFavorite(color) ? "heart.fill" : "heart")
                }
                .accessibilityLabel(store.isFavorite(color) ? "إزالة من المفضلة" : "إضافة للمفضلة")
            }
        }
    }
}

/// شارات الغرف المناسبة للون.
private struct FlowRooms: View {
    let rooms: [Room]

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(spacing: 8) { badges }
            VStack(alignment: .leading, spacing: 8) {
                ForEach(chunks, id: \.first) { row in
                    HStack(spacing: 8) {
                        ForEach(row) { room in badge(room) }
                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }

    private var chunks: [[Room]] {
        stride(from: 0, to: rooms.count, by: 2).map {
            Array(rooms[$0 ..< min($0 + 2, rooms.count)])
        }
    }

    private var badges: some View {
        ForEach(rooms) { badge($0) }
    }

    private func badge(_ room: Room) -> some View {
        Label(room.title, systemImage: room.symbol)
            .font(.caption.weight(.medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.tint.opacity(0.14), in: Capsule())
    }
}
