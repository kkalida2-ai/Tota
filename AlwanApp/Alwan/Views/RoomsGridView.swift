import SwiftUI

struct RoomsGridView: View {
    @Environment(FavoritesStore.self) private var store

    private let columns = [GridItem(.adaptive(minimum: 150), spacing: 14)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("اختر مكاناً في البيت، وسأعرض لك الألوان المناسبة له — ولماذا، ووين بالضبط تستخدمه.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)

                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(Room.allCases) { room in
                            NavigationLink(value: room) {
                                RoomTile(room: room, chosen: store.chosenColor(for: room))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("ألوان البيت")
            .navigationDestination(for: Room.self) { RoomDetailView(room: $0) }
        }
    }
}

private struct RoomTile: View {
    let room: Room
    let chosen: PaintColor?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                (chosen?.color ?? Color.gray.opacity(0.22))
                    .frame(height: 86)
                    .overlay(
                        LinearGradient(
                            colors: [.white.opacity(0.18), .clear],
                            startPoint: .top, endPoint: .bottom
                        )
                    )
                Image(systemName: room.symbol)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(chosen?.readableInk ?? .secondary)
                    .padding(10)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(room.title)
                    .font(.subheadline.weight(.semibold))
                Text(chosen.map { "اخترت: \($0.name)" } ?? "\(ColorCatalog.colors(for: room).count) لون مقترح")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
        }
        .background(.background.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.primary.opacity(0.08), lineWidth: 1)
        )
    }
}
