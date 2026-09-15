import SwiftUI

/// منطقة من مناطق المنزل. لكل منطقة طابعها الخاص ولوحة ألوان تناسبها.
enum Room: String, CaseIterable, Identifiable, Codable, Sendable {
    case majlis
    case living
    case dining
    case masterBedroom
    case kidsRoom
    case kitchen
    case bathroom
    case hallway
    case office
    case outdoor

    var id: String { rawValue }

    var title: String {
        switch self {
        case .majlis:         "المجلس"
        case .living:         "صالة المعيشة"
        case .dining:         "غرفة الطعام"
        case .masterBedroom:  "غرفة النوم الرئيسية"
        case .kidsRoom:       "غرفة الأطفال"
        case .kitchen:        "المطبخ"
        case .bathroom:       "دورة المياه"
        case .hallway:        "المدخل والممرات"
        case .office:         "المكتب والدراسة"
        case .outdoor:        "الحوش والسطح"
        }
    }

    var symbol: String {
        switch self {
        case .majlis:         "sofa.fill"
        case .living:         "tv.fill"
        case .dining:         "fork.knife"
        case .masterBedroom:  "bed.double.fill"
        case .kidsRoom:       "teddybear.fill"
        case .kitchen:        "refrigerator.fill"
        case .bathroom:       "shower.fill"
        case .hallway:        "door.left.hand.open"
        case .office:         "book.closed.fill"
        case .outdoor:        "sun.max.fill"
        }
    }

    /// «حق شنو» على مستوى الغرفة: ما الذي نريد أن يفعله اللون هنا.
    var goal: String {
        switch self {
        case .majlis:
            "مكان استقبال الضيوف: نريد لوناً يعطي وقاراً واتساعاً، فاتح على الجدران الأربعة مع جدار واحد أغمق خلف الكنب."
        case .living:
            "مكان الجلسة اليومية للعائلة: لون دافئ مريح للعين لساعات طويلة، ولا يتعب مع إضاءة التلفزيون."
        case .dining:
            "الألوان الدافئة والترابية تفتح الشهية وتجعل الطعام يبدو ألذ، وتجمع الناس حول الطاولة."
        case .masterBedroom:
            "الهدف نوم عميق: ألوان خافتة منخفضة التشبّع تهدئ الأعصاب، وابتعد عن الأحمر والبرتقالي القوي."
        case .kidsRoom:
            "لون يحفّز اللعب لكن لا يمنع النوم: باستيل هادئ على الجدران، والألوان القوية في الأثاث والستائر فقط."
        case .kitchen:
            "نظافة ووضوح: ألوان فاتحة تُظهر النظافة، ودهان قابل للمسح لأن البخار والدهن يلتصقان بالجدار."
        case .bathroom:
            "مساحة صغيرة ورطبة: الفاتح يوسّعها، والدهان يجب أن يكون مقاوماً للرطوبة وإلا تقشّر خلال سنة."
        case .hallway:
            "أول انطباع عن البيت، وغالباً بلا نوافذ: اللون الفاتح العاكس ضروري وإلا صار الممر نفقاً مظلماً."
        case .office:
            "تركيز طويل: ألوان باردة هادئة ترفع الانتباه، وتجنّب الأبيض الناصع لأنه يجهد العين مع الشاشة."
        case .outdoor:
            "يتعرض للشمس والغبار: ألوان ترابية لا يظهر عليها الغبار، ودهان خارجي مقاوم للأشعة وإلا بهت خلال صيفين."
        }
    }

    /// نصيحة سريعة مرتبطة بالإضاءة والمساحة.
    var tip: String {
        switch self {
        case .majlis:        "جرّب اللون على الجدار ليلاً تحت الثريا، لأن الإضاءة الصفراء تسحب اللون نحو الأصفر."
        case .living:        "إذا كان الجدار خلف التلفزيون أغمق، تقل إجهاد العين من فرق الإضاءة."
        case .dining:        "الأزرق الصريح يقلل الشهية — اتركه للمكتب لا لغرفة الطعام."
        case .masterBedroom: "السقف بلون أفتح درجة من الجدران يجعل الغرفة تتنفس."
        case .kidsRoom:      "اترك جداراً واحداً بدهان سبورة أو مغناطيسي، يوفّر عليك تشطيب الجدران الباقية."
        case .kitchen:       "اختر «نصف لامع» على الأقل — المطفي جميل لكنه لا يُمسح."
        case .bathroom:      "لا تستخدم الدهان المطفي هنا إطلاقاً، ولا بد من شفاط أو نافذة."
        case .hallway:       "نفس لون الصالة بدرجة أفتح يجعل البيت يبدو أكبر وأكثر انسجاماً."
        case .office:        "اجعل الجدار الذي خلف الشاشة متوسط الغمق، لا فاتحاً ناصعاً."
        case .outdoor:       "الألوان الغامقة تمتص الحرارة وترفع حرارة الجدار — تجنّبها في الواجهة الجنوبية."
        }
    }
}
