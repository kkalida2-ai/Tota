import SwiftUI

enum ColorFamily: String, CaseIterable, Identifiable, Codable, Sendable {
    case neutral, warm, cool, earthy, deep, pastel

    var id: String { rawValue }

    var title: String {
        switch self {
        case .neutral: "محايد"
        case .warm:    "دافئ"
        case .cool:    "بارد"
        case .earthy:  "ترابي"
        case .deep:    "غامق"
        case .pastel:  "باستيل"
        }
    }
}

enum Finish: String, Codable, Sendable {
    case matte, eggshell, satin, semiGloss

    var title: String {
        switch self {
        case .matte:     "مطفي"
        case .eggshell:  "قشر بيض"
        case .satin:     "ساتان"
        case .semiGloss: "نصف لامع"
        }
    }

    var note: String {
        switch self {
        case .matte:     "يخفي عيوب الجدار، لكنه لا يتحمّل المسح."
        case .eggshell:  "لمعة خفيفة تتحمّل مسحة قماش مبللة."
        case .satin:     "يُمسح بسهولة، مناسب للممرات وغرف الأطفال."
        case .semiGloss: "مقاوم للرطوبة والدهون — للمطبخ والحمام."
        }
    }
}

/// لون دهان واحد مع كل ما يحتاجه المستخدم ليقرر.
struct PaintColor: Identifiable, Hashable, Sendable {
    let id: String          // رمز اللون، مثل AL-104
    let name: String        // الاسم بالعربي
    let hex: String         // اللون نفسه
    let family: ColorFamily
    let purpose: String     // حق شنو — الأثر والفائدة
    let usage: String       // وين استخدمه — بالضبط أي جدار
    let lighting: String    // سلوك اللون مع الإضاءة
    let finish: Finish
    let pairs: [String]     // ألوان منسجمة معه (hex)
    let rooms: [Room]

    var color: Color { Color(hex: hex) }

    /// درجة السطوع (0 غامق، 1 فاتح) — تُستخدم لاختيار لون نص مقروء فوق اللون.
    var luminance: Double { Color.relativeLuminance(hex: hex) }

    var readableInk: Color { luminance > 0.55 ? .black.opacity(0.82) : .white.opacity(0.95) }

    var isLight: Bool { luminance > 0.55 }
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let v = UInt64(s, radix: 16) ?? 0
        self.init(
            .sRGB,
            red:   Double((v >> 16) & 0xFF) / 255,
            green: Double((v >> 8)  & 0xFF) / 255,
            blue:  Double(v & 0xFF) / 255,
            opacity: 1
        )
    }

    static func relativeLuminance(hex: String) -> Double {
        let s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let v = UInt64(s, radix: 16) ?? 0
        func channel(_ raw: UInt64) -> Double {
            let c = Double(raw) / 255
            return c <= 0.03928 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
        }
        return 0.2126 * channel((v >> 16) & 0xFF)
             + 0.7152 * channel((v >> 8) & 0xFF)
             + 0.0722 * channel(v & 0xFF)
    }
}
