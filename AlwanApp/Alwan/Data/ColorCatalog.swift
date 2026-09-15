import Foundation

/// كتالوج الألوان. كل لون يجيب على سؤالين: حق شنو؟ ووين استخدمه؟
enum ColorCatalog {

    static let all: [PaintColor] = [

        // ─────────── محايدة وفاتحة ───────────
        PaintColor(
            id: "AL-101", name: "رمل ناعم", hex: "EDE4D6", family: .neutral,
            purpose: "أبيض دافئ لا يميل للأصفر ولا للرمادي. يريح العين ويجعل الغرفة تبدو أنظف وأوسع بلا برود.",
            usage: "الجدران الأربعة في المجلس والصالة، وأي غرفة تريد أن تبدأ منها بلوحة آمنة لا تمل منها.",
            lighting: "ممتاز مع الإضاءة الصفراء؛ تحت الليد الأبيض يميل قليلاً للرمادي.",
            finish: .matte, pairs: ["3E4A45", "C29A6B", "FFFFFF"],
            rooms: [.majlis, .living, .hallway, .dining, .masterBedroom]
        ),
        PaintColor(
            id: "AL-102", name: "أبيض حليبي", hex: "F7F3EC", family: .neutral,
            purpose: "أفتح من الرمل بدرجة. يعكس أكبر قدر من الضوء، فهو أفضل خيار لمساحة صغيرة أو مظلمة.",
            usage: "الأسقف في كل البيت، والممرات الضيقة بلا نوافذ، والحمامات الصغيرة.",
            lighting: "يحتاج ضوءاً جيداً وإلا بدا باهتاً وبلا شخصية.",
            finish: .eggshell, pairs: ["D9C7B0", "8FA3A8", "2E3336"],
            rooms: [.hallway, .bathroom, .kitchen, .living]
        ),
        PaintColor(
            id: "AL-103", name: "رمادي دخاني", hex: "C9C6C0", family: .neutral,
            purpose: "رمادي مغبّر فيه دفء. خلفية محايدة تُبرز الأثاث واللوحات بدل أن تنافسها.",
            usage: "جدار التلفزيون في الصالة، وجدران المكتب، وخلفية الأرفف المفتوحة.",
            lighting: "ثابت تحت كل الإضاءات — من أكثر الألوان أماناً.",
            finish: .eggshell, pairs: ["3B3F46", "C9A227", "F7F3EC"],
            rooms: [.living, .office, .hallway, .dining]
        ),
        PaintColor(
            id: "AL-104", name: "بيج قهوة بحليب", hex: "DCC9AE", family: .warm,
            purpose: "دفء هادئ يعطي إحساس الكرم والاستقبال، ولا يظهر عليه الغبار بسرعة.",
            usage: "المجلس والمدخل. ممتاز على الجدران التي تلمسها الأيدي كثيراً.",
            lighting: "يزداد جمالاً مع الإضاءة الدافئة مساءً.",
            finish: .eggshell, pairs: ["6B4F3A", "2F3E46", "F7F3EC"],
            rooms: [.majlis, .hallway, .dining, .living]
        ),
        PaintColor(
            id: "AL-105", name: "جبس أبيض", hex: "FFFFFF", family: .neutral,
            purpose: "الأبيض الصريح. يوسّع بشكل أقصى ويُظهر الزوايا المعمارية والجبس بوضوح.",
            usage: "الأسقف والكرانيش والأبواب والنوافذ — لا تستخدمه على جدران المكتب فهو مُجهد للعين مع الشاشة.",
            lighting: "يعكس الضوء كله، وقد يسبب وهجاً في الغرف الشديدة الإضاءة.",
            finish: .semiGloss, pairs: ["1F2937", "D6C2A8", "8FA3A8"],
            rooms: [.kitchen, .bathroom, .hallway, .living]
        ),

        // ─────────── دافئة وترابية ───────────
        PaintColor(
            id: "AL-201", name: "طين محروق", hex: "B4694C", family: .earthy,
            purpose: "لون ترابي قوي يفتح الشهية ويعطي دفئاً فورياً. مستوحى من الطين والفخار.",
            usage: "جدار واحد فقط — خلف طاولة الطعام أو خلف الكنب. لا تدهن به الغرفة كلها.",
            lighting: "يشتعل مع الإضاءة الدافئة؛ تحت الضوء الأبيض يصبح باهتاً.",
            finish: .matte, pairs: ["EDE4D6", "3E4A45", "C9A227"],
            rooms: [.dining, .majlis, .living]
        ),
        PaintColor(
            id: "AL-202", name: "رمل الصحراء", hex: "D6BE9A", family: .earthy,
            purpose: "لون محلي مألوف، لا يظهر عليه الغبار، ويعطي إحساس الأصالة والهدوء.",
            usage: "الحوش والواجهات الخارجية، والمجلس ذي الطابع التقليدي.",
            lighting: "يتحمّل الشمس المباشرة دون أن يبهت بسرعة.",
            finish: .satin, pairs: ["7A5C3E", "2F3E46", "F7F3EC"],
            rooms: [.outdoor, .majlis, .hallway]
        ),
        PaintColor(
            id: "AL-203", name: "قرفة", hex: "8C5A3C", family: .earthy,
            purpose: "بني محمّر غني. يمنح الغرفة ثقلاً ووقاراً ويجعلها تبدو أدفأ في الشتاء.",
            usage: "جدار المدفأة أو الجدار خلف رأس السرير. يحتاج إضاءة جيدة.",
            lighting: "يبتلع الضوء — لا تستخدمه في غرفة بنافذة واحدة صغيرة.",
            finish: .matte, pairs: ["EDE4D6", "C9A227", "3E4A45"],
            rooms: [.majlis, .masterBedroom, .dining]
        ),
        PaintColor(
            id: "AL-204", name: "عسل", hex: "E0B16A", family: .warm,
            purpose: "أصفر ذهبي مكتوم يرفع المزاج ويضيء الغرف المعتمة دون صخب.",
            usage: "الممر الداخلي المظلم، أو جدار الدرج، أو ركن القراءة.",
            lighting: "يعوّض نقص ضوء الشمس في الغرف الشمالية.",
            finish: .eggshell, pairs: ["2F3E46", "F7F3EC", "8C5A3C"],
            rooms: [.hallway, .kidsRoom, .living]
        ),
        PaintColor(
            id: "AL-205", name: "وردي طيني", hex: "D9A99C", family: .warm,
            purpose: "وردي مغبّر ناضج، ليس طفولياً. يعطي نعومة ودفئاً ويجمل لون البشرة في المرايا.",
            usage: "غرفة النوم، غرفة الملابس، وجدار المرآة في غرفة التزيين.",
            lighting: "جميل مع الإضاءة الدافئة الخافتة.",
            finish: .matte, pairs: ["F7F3EC", "6B4F3A", "A7B5A0"],
            rooms: [.masterBedroom, .kidsRoom, .bathroom]
        ),

        // ─────────── باردة ───────────
        PaintColor(
            id: "AL-301", name: "أزرق ضبابي", hex: "9FB3C8", family: .cool,
            purpose: "أزرق رمادي هادئ يبطئ النَفَس ويخفض التوتر — من أفضل ألوان النوم.",
            usage: "جدران غرفة النوم كلها، أو جدار السرير وحده مع باقي الجدران فاتحة.",
            lighting: "يميل للرمادي في الضوء الصفراوي، فاستخدم إضاءة محايدة.",
            finish: .matte, pairs: ["F7F3EC", "2F3E46", "D6C2A8"],
            rooms: [.masterBedroom, .office, .bathroom, .kidsRoom]
        ),
        PaintColor(
            id: "AL-302", name: "أخضر مريمية", hex: "A7B5A0", family: .cool,
            purpose: "أخضر مغبّر يريح العين أكثر من أي لون آخر، ويربط الداخل بالطبيعة.",
            usage: "المكتب وغرفة الدراسة، وخزائن المطبخ، وجدار النباتات.",
            lighting: "ثابت ولطيف في كل الإضاءات.",
            finish: .eggshell, pairs: ["EDE4D6", "6B4F3A", "2E3B34"],
            rooms: [.office, .kitchen, .masterBedroom, .living]
        ),
        PaintColor(
            id: "AL-303", name: "أزرق بحري", hex: "2F5D7C", family: .cool,
            purpose: "أزرق عميق يرفع التركيز ويعطي وقاراً رسمياً. يجعل الأبيض حوله يبدو أنصع.",
            usage: "جدار المكتب خلف الكرسي (يظهر جيداً في اجتماعات الفيديو)، وجدار واحد في المجلس.",
            lighting: "يحتاج إضاءة قوية؛ في الغرفة المظلمة يبدو أسود.",
            finish: .eggshell, pairs: ["F7F3EC", "C9A227", "D6C2A8"],
            rooms: [.office, .majlis, .kidsRoom]
        ),
        PaintColor(
            id: "AL-304", name: "نعناع باهت", hex: "C7DED4", family: .pastel,
            purpose: "بارد ومنعش، يعطي إحساس النظافة والانتعاش في المساحات الصغيرة.",
            usage: "دورة المياه، والمغسلة، وغرفة الغسيل.",
            lighting: "منعش في ضوء النهار؛ يبهت تحت الإضاءة الصفراء.",
            finish: .semiGloss, pairs: ["FFFFFF", "2F5D7C", "D6C2A8"],
            rooms: [.bathroom, .kitchen, .kidsRoom]
        ),
        PaintColor(
            id: "AL-305", name: "سماوي فاتح", hex: "CFE0EC", family: .pastel,
            purpose: "يوسّع الغرفة ويرفع السقف بصرياً، ويهدّئ الأطفال كثيري الحركة.",
            usage: "غرفة الأطفال، وسقف الغرفة الصغيرة، ودورة المياه.",
            lighting: "يحتاج ضوء نهار وإلا بدا رمادياً.",
            finish: .satin, pairs: ["FFFFFF", "E0B16A", "2F5D7C"],
            rooms: [.kidsRoom, .bathroom, .masterBedroom]
        ),

        // ─────────── باستيل للأطفال ───────────
        PaintColor(
            id: "AL-401", name: "مشمش باهت", hex: "F3D2B6", family: .pastel,
            purpose: "دافئ ومرح دون أن يكون صاخباً، فلا يمنع الطفل من النوم.",
            usage: "غرفة الأطفال الصغار، وركن اللعب، وغرفة الرضيع.",
            lighting: "لطيف ليلاً مع الإضاءة الخافتة.",
            finish: .satin, pairs: ["FFFFFF", "A7B5A0", "9FB3C8"],
            rooms: [.kidsRoom, .masterBedroom]
        ),
        PaintColor(
            id: "AL-402", name: "ليمون كريمي", hex: "F2E3B3", family: .pastel,
            purpose: "يبعث النشاط والبهجة في الصباح ويضيء الغرفة بلا إجهاد.",
            usage: "ركن الدراسة في غرفة الطفل، وغرفة الإفطار، والمطبخ الصغير.",
            lighting: "قوي جداً في الشمس المباشرة — جرّبه على جدار صغير أولاً.",
            finish: .satin, pairs: ["FFFFFF", "A7B5A0", "6B4F3A"],
            rooms: [.kidsRoom, .kitchen, .dining]
        ),
        PaintColor(
            id: "AL-403", name: "بنفسجي ضبابي", hex: "C8BFD6", family: .pastel,
            purpose: "هادئ وحالم، يناسب غرف البنات دون أن يكون وردياً مبتذلاً.",
            usage: "غرفة الأطفال، وغرفة النوم، وجدار السرير.",
            lighting: "يميل للرمادي في الضوء البارد.",
            finish: .matte, pairs: ["F7F3EC", "9FB3C8", "D9A99C"],
            rooms: [.kidsRoom, .masterBedroom]
        ),

        // ─────────── غامقة ───────────
        PaintColor(
            id: "AL-501", name: "أخضر زيتوني غامق", hex: "3E4A45", family: .deep,
            purpose: "يعطي عمقاً وفخامة، ويجعل الذهب والخشب يلمعان أمامه.",
            usage: "جدار واحد في المجلس خلف الكنب، أو خزائن المطبخ السفلية، أو مكتبة الكتب.",
            lighting: "يحتاج إضاءة موجّهة (سبوتات) وإلا صار الجدار ثقيلاً.",
            finish: .eggshell, pairs: ["EDE4D6", "C9A227", "D6C2A8"],
            rooms: [.majlis, .living, .kitchen, .office]
        ),
        PaintColor(
            id: "AL-502", name: "كحلي ليلي", hex: "22314A", family: .deep,
            purpose: "يهيّئ للنوم لأنه يقلّل انعكاس الضوء، ويعطي إحساس الغرفة الفندقية.",
            usage: "الجدار خلف رأس السرير فقط، أو جدار الشاشة في غرفة السينما.",
            lighting: "يمتص الضوء — لا تستخدمه في غرفة صغيرة بلا نافذة.",
            finish: .matte, pairs: ["F7F3EC", "C9A227", "9FB3C8"],
            rooms: [.masterBedroom, .living, .office]
        ),
        PaintColor(
            id: "AL-503", name: "فحمي", hex: "2E3336", family: .deep,
            purpose: "خلفية درامية تُخفي بصمات الأيدي، وتُبرز أي شيء أبيض أمامها.",
            usage: "جدار التلفزيون، وداخل الرفوف، وإطار الباب الحديدي.",
            lighting: "لا تستخدمه على أكثر من جدار واحد في نفس الغرفة.",
            finish: .eggshell, pairs: ["FFFFFF", "C9A227", "C9C6C0"],
            rooms: [.living, .office, .hallway]
        ),
        PaintColor(
            id: "AL-504", name: "عنابي", hex: "6E2F3A", family: .deep,
            purpose: "لون غني يرفع مستوى المكان ويعطي إحساس الدفء والسخاء.",
            usage: "جدار غرفة الطعام، أو ركن المجلس الرسمي، أو مدخل البيت.",
            lighting: "يحتاج إضاءة دافئة قوية.",
            finish: .matte, pairs: ["EDE4D6", "C9A227", "3E4A45"],
            rooms: [.dining, .majlis, .hallway]
        ),

        // ─────────── مطبخ وحمام ───────────
        PaintColor(
            id: "AL-601", name: "أبيض قشدي", hex: "F1EBE0", family: .neutral,
            purpose: "أبيض دافئ يُظهر نظافة المطبخ ولا يصفرّ بسرعة مع البخار.",
            usage: "جدران المطبخ فوق الرخام، وسقف الحمام.",
            lighting: "آمن في كل الإضاءات.",
            finish: .semiGloss, pairs: ["3E4A45", "C9C6C0", "2F5D7C"],
            rooms: [.kitchen, .bathroom, .hallway]
        ),
        PaintColor(
            id: "AL-602", name: "رمادي إسمنتي", hex: "8A8F93", family: .neutral,
            purpose: "عملي وحديث، لا يظهر عليه أثر الماء أو البقع الخفيفة.",
            usage: "غرفة الغسيل، وحمام الضيوف، وجدار الشواية في الحوش.",
            lighting: "يبدو أغمق ليلاً بدرجتين.",
            finish: .satin, pairs: ["FFFFFF", "C9A227", "2E3336"],
            rooms: [.bathroom, .outdoor, .kitchen]
        ),
        PaintColor(
            id: "AL-603", name: "أخضر بحري غامق", hex: "27514C", family: .deep,
            purpose: "يعطي حمام الضيوف طابعاً فندقياً مع الذهبي، ويخفي آثار الرطوبة أكثر من الفاتح.",
            usage: "حمام الضيوف الصغير — اجعل السقف فاتحاً كي لا يختنق.",
            lighting: "لا بد من إضاءة مرآة قوية.",
            finish: .semiGloss, pairs: ["F1EBE0", "C9A227", "D6C2A8"],
            rooms: [.bathroom, .kitchen]
        ),

        // ─────────── خارجي ───────────
        PaintColor(
            id: "AL-701", name: "حجر جيري", hex: "D8D2C6", family: .earthy,
            purpose: "يعكس حرارة الشمس ويبقي الجدار أبرد، ولا يظهر عليه الغبار.",
            usage: "الواجهة الخارجية وجدران الحوش والسور.",
            lighting: "مصمم للشمس المباشرة.",
            finish: .satin, pairs: ["7A5C3E", "3E4A45", "FFFFFF"],
            rooms: [.outdoor]
        ),
        PaintColor(
            id: "AL-702", name: "بني جوزي", hex: "7A5C3E", family: .earthy,
            purpose: "يشبه لون الخشب، يناسب البرجولات والأبواب الخارجية ويداري الأتربة.",
            usage: "إطارات الأبواب والشبابيك الخارجية والبرجولا.",
            lighting: "يمتص الحرارة — للتفاصيل لا للمساحات الكبيرة المشمسة.",
            finish: .satin, pairs: ["D8D2C6", "A7B5A0", "EDE4D6"],
            rooms: [.outdoor, .hallway]
        ),
        PaintColor(
            id: "AL-703", name: "ذهبي رملي", hex: "C9A227", family: .warm,
            purpose: "لمسة فخامة صغيرة. يُستخدم كتفصيل لا كلون جدار كامل.",
            usage: "الكرانيش، وإطار المرآة، وخط زخرفي في المجلس أو المدخل.",
            lighting: "يتألق تحت الإضاءة الموجّهة.",
            finish: .semiGloss, pairs: ["2E3336", "22314A", "EDE4D6"],
            rooms: [.majlis, .hallway, .dining]
        ),
        PaintColor(
            id: "AL-704", name: "زيتي فاتح", hex: "B7BFA8", family: .cool,
            purpose: "أخضر مغبّر فاتح يربط الحوش بالنباتات ويبقى هادئاً تحت الشمس.",
            usage: "جدار الجلسة الخارجية، وسور الحديقة، وغرفة الشغالة أو المخزن.",
            lighting: "يتحمّل الشمس جيداً.",
            finish: .satin, pairs: ["F7F3EC", "7A5C3E", "3E4A45"],
            rooms: [.outdoor, .kitchen, .office]
        ),

        // ─────────── إضافات للممرات والمداخل ───────────
        PaintColor(
            id: "AL-801", name: "بيج مدخّن", hex: "C4B5A0", family: .neutral,
            purpose: "وسط بين البيج والرمادي — لا يميل لأي جهة، فيناسب أي أثاث ستغيّره لاحقاً.",
            usage: "الممرات وجدران الدرج والمساحات الانتقالية بين الغرف.",
            lighting: "ثابت جداً تحت أي إضاءة.",
            finish: .satin, pairs: ["F7F3EC", "2E3336", "8C5A3C"],
            rooms: [.hallway, .living, .majlis, .office]
        ),
        PaintColor(
            id: "AL-802", name: "أخضر سبورة", hex: "2E3B34", family: .deep,
            purpose: "يمكن استخدام دهان السبورة بهذا اللون ليكتب عليه الأطفال بالطباشير.",
            usage: "جدار واحد في غرفة الأطفال أو ركن المطبخ لقائمة المشتريات.",
            lighting: "يحتاج إضاءة جانبية.",
            finish: .matte, pairs: ["F2E3B3", "FFFFFF", "E0B16A"],
            rooms: [.kidsRoom, .kitchen, .office]
        ),
        PaintColor(
            id: "AL-803", name: "تراكوتا فاتح", hex: "E3B79A", family: .warm,
            purpose: "دفء خفيف يجعل المدخل مرحّباً من أول خطوة.",
            usage: "المدخل الرئيسي، وجدار الدرج، وغرفة الطعام الصغيرة.",
            lighting: "يزداد جمالاً في الغروب.",
            finish: .eggshell, pairs: ["F7F3EC", "3E4A45", "7A5C3E"],
            rooms: [.hallway, .dining, .living]
        ),
        PaintColor(
            id: "AL-804", name: "رمادي أزرق", hex: "7D8A93", family: .cool,
            purpose: "رصين وهادئ، خلفية ممتازة للصور المعلّقة والأعمال الفنية.",
            usage: "جدار المكتب، وجدار الصور في الممر، وغرفة الشباب.",
            lighting: "يبدو أزرق نهاراً ورمادياً ليلاً.",
            finish: .eggshell, pairs: ["F7F3EC", "C9A227", "22314A"],
            rooms: [.office, .hallway, .masterBedroom, .living]
        )
    ]

    static func colors(for room: Room) -> [PaintColor] {
        all.filter { $0.rooms.contains(room) }
    }

    static func color(id: String) -> PaintColor? {
        all.first { $0.id == id }
    }

    /// بحث بسيط في الاسم والرمز ووصف الاستخدام.
    static func search(_ query: String) -> [PaintColor] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return all }
        return all.filter {
            $0.name.localizedCaseInsensitiveContains(q)
            || $0.id.localizedCaseInsensitiveContains(q)
            || $0.usage.localizedCaseInsensitiveContains(q)
            || $0.purpose.localizedCaseInsensitiveContains(q)
            || $0.family.title.localizedCaseInsensitiveContains(q)
        }
    }
}
