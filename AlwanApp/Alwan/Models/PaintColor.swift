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

// MARK: - مطابقة الألوان

/// نقطة لون في فضاء CIELAB — يقيس الفرق كما تراه العين، لا كما تخزنه الشاشة.
struct LabColor: Sendable {
    let l: Double, a: Double, b: Double

    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let v = UInt64(s, radix: 16) ?? 0
        self.init(
            r: Int((v >> 16) & 0xFF),
            g: Int((v >> 8) & 0xFF),
            b: Int(v & 0xFF)
        )
    }

    init(r: Int, g: Int, b: Int) {
        func linear(_ raw: Int) -> Double {
            let c = Double(raw) / 255
            return c <= 0.04045 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
        }
        let rl = linear(r), gl = linear(g), bl = linear(b)

        // sRGB → XYZ (D65)
        let x = (0.4124 * rl + 0.3576 * gl + 0.1805 * bl) / 0.95047
        let y =  0.2126 * rl + 0.7152 * gl + 0.0722 * bl
        let z = (0.0193 * rl + 0.1192 * gl + 0.9505 * bl) / 1.08883

        func f(_ t: Double) -> Double {
            t > 0.008856 ? pow(t, 1.0 / 3.0) : (7.787 * t) + 16.0 / 116.0
        }
        let fx = f(x), fy = f(y), fz = f(z)

        self.l = 116 * fy - 16
        self.a = 500 * (fx - fy)
        self.b = 200 * (fy - fz)
    }

    /// فرق اللون ΔE. أقل من ٢ لا تكاد العين تميزه، وفوق ١٠ لونان مختلفان.
    func distance(to other: LabColor) -> Double {
        let dl = l - other.l, da = a - other.a, db = b - other.b
        return (dl * dl + da * da + db * db).squareRoot()
    }
}

extension PaintColor {
    var lab: LabColor { LabColor(hex: hex) }
}

extension ColorCatalog {
    /// أقرب ألوان الكتالوج إلى لون التُقط من صورة.
    static func nearest(to target: LabColor, limit: Int = 4) -> [(color: PaintColor, delta: Double)] {
        all.map { ($0, $0.lab.distance(to: target)) }
            .sorted { $0.1 < $1.1 }
            .prefix(limit)
            .map { (color: $0.0, delta: $0.1) }
    }
}
