import SwiftUI

/// بطاقة لون في القوائم.
struct ColorCard: View {
    let color: PaintColor
    var showsRoomHint: Bool = true

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(color.color)
                .frame(width: 64, height: 64)
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(.primary.opacity(0.12), lineWidth: 1)
                )
                .overlay(alignment: .bottomTrailing) {
                    Text(color.id)
                        .font(.system(size: 9, weight: .semibold, design: .monospaced))
                        .foregroundStyle(color.readableInk)
                        .padding(4)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(color.name)
                    .font(.headline)
                Text(color.purpose)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                if showsRoomHint {
                    Text(color.family.title + " · " + color.finish.title)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.vertical, 6)
        .contentShape(.rect)
    }
}

/// صف معلومة بعنوان ونص، مع أيقونة.
struct InfoRow: View {
    let symbol: String
    let title: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.tint)
                .frame(width: 24)
                .padding(.top, 2)
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(text)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 2)
    }
}

/// دوائر الألوان المنسجمة.
struct PairStrip: View {
    let hexes: [String]

    var body: some View {
        HStack(spacing: 10) {
            ForEach(hexes, id: \.self) { hex in
                VStack(spacing: 5) {
                    Circle()
                        .fill(Color(hex: hex))
                        .frame(width: 38, height: 38)
                        .overlay(Circle().strokeBorder(.primary.opacity(0.12), lineWidth: 1))
                    Text("#\(hex)")
                        .font(.system(size: 9, design: .monospaced))
                        .foregroundStyle(.tertiary)
                }
            }
            Spacer(minLength: 0)
        }
    }
}
