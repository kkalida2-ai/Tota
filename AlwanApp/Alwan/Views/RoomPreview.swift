import SwiftUI

/// نوع الإضاءة في المعاينة — نفس اللون يتغير كثيراً بين النهار والمساء.
enum PreviewLighting: String, CaseIterable, Identifiable {
    case day, warm, cool

    var id: String { rawValue }

    var title: String {
        switch self {
        case .day:  "ضوء النهار"
        case .warm: "إضاءة صفراء"
        case .cool: "ليد أبيض"
        }
    }

    var tint: Color {
        switch self {
        case .day:  .clear
        case .warm: Color(hex: "FF9D3D")
        case .cool: Color(hex: "BFD4FF")
        }
    }

    var tintOpacity: Double {
        switch self {
        case .day:  0
        case .warm: 0.22
        case .cool: 0.14
        }
    }

    var dimming: Double {
        switch self {
        case .day:  0
        case .warm: 0.12
        case .cool: 0.02
        }
    }
}

/// معاينة مبسّطة لغرفة مدهونة باللون المختار، حتى يتخيّل المستخدم النتيجة قبل الشراء.
struct RoomPreview: View {
    let color: PaintColor
    var room: Room = .living
    var lighting: PreviewLighting = .day
    var height: CGFloat = 240

    private var accent: Color { Color(hex: color.pairs.first ?? "FFFFFF") }

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let floorTop = h * 0.74

            ZStack(alignment: .bottom) {
                // الجدار
                color.color
                    .overlay(
                        // ضوء نافذة يسقط من الجهة العلوية
                        LinearGradient(
                            colors: [.white.opacity(0.22), .clear, .black.opacity(0.14)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                // الأرضية
                VStack(spacing: 0) {
                    Spacer()
                    LinearGradient(
                        colors: [Color(hex: "B3906A"), Color(hex: "8A6A4B")],
                        startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: h - floorTop)
                }

                // وزرة الجدار
                VStack(spacing: 0) {
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: "F7F3EC"))
                        .frame(height: 6)
                        .offset(y: -(h - floorTop))
                }

                // أثاث بسيط حسب نوع الغرفة
                furniture(width: w, height: h, floorTop: floorTop)

                // طبقة الإضاءة فوق المشهد كله
                Rectangle()
                    .fill(lighting.tint.opacity(lighting.tintOpacity))
                    .blendMode(.multiply)
                    .allowsHitTesting(false)
                Rectangle()
                    .fill(.black.opacity(lighting.dimming))
                    .allowsHitTesting(false)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .strokeBorder(.white.opacity(0.14), lineWidth: 1)
            )
        }
        .frame(height: height)
        .accessibilityLabel("معاينة \(room.title) بلون \(color.name)")
    }

    @ViewBuilder
    private func furniture(width w: CGFloat, height h: CGFloat, floorTop: CGFloat) -> some View {
        switch room {
        case .masterBedroom, .kidsRoom:
            ZStack(alignment: .bottom) {
                // لوح رأس السرير
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(accent)
                    .frame(width: w * 0.52, height: h * 0.30)
                    .offset(y: -(h - floorTop) - h * 0.14)
                // المرتبة
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(hex: "F3EFE7"))
                    .frame(width: w * 0.58, height: h * 0.16)
                    .offset(y: -(h - floorTop) + h * 0.10)
            }
        case .kitchen, .bathroom:
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color(hex: "EFEFEA"))
                    .frame(width: w * 0.66, height: h * 0.10)
                    .offset(y: -(h - floorTop) + h * 0.06)
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(accent)
                    .frame(width: w * 0.30, height: h * 0.22)
                    .offset(x: w * 0.22, y: -(h - floorTop) - h * 0.16)
            }
        case .office:
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(hex: "2E3336"))
                    .frame(width: w * 0.30, height: h * 0.18)
                    .offset(y: -(h - floorTop) - h * 0.04)
                Rectangle()
                    .fill(Color(hex: "7A5C3E"))
                    .frame(width: w * 0.50, height: h * 0.03)
                    .offset(y: -(h - floorTop) + h * 0.01)
            }
        case .outdoor:
            ZStack(alignment: .bottom) {
                Circle()
                    .fill(Color(hex: "5C7A4E"))
                    .frame(width: w * 0.22, height: w * 0.22)
                    .offset(x: -w * 0.28, y: -(h - floorTop) + h * 0.02)
                RoundedRectangle(cornerRadius: 6)
                    .fill(accent)
                    .frame(width: w * 0.34, height: h * 0.14)
                    .offset(x: w * 0.20, y: -(h - floorTop) + h * 0.05)
            }
        default:
            ZStack(alignment: .bottom) {
                // كنب
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(accent)
                    .frame(width: w * 0.60, height: h * 0.20)
                    .offset(y: -(h - floorTop) + h * 0.10)
                // لوحة على الجدار
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color(hex: "F7F3EC"))
                    .frame(width: w * 0.16, height: h * 0.20)
                    .offset(x: w * 0.26, y: -(h - floorTop) - h * 0.24)
            }
        }
    }
}
