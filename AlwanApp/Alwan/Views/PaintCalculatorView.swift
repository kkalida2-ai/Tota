import SwiftUI

/// حاسبة كمية الدهان: أبعاد الغرفة ← عدد اللترات والجالونات المطلوبة.
struct PaintCalculatorView: View {
    @State private var length = 5.0        // متر
    @State private var width = 4.0
    @State private var height = 3.0
    @State private var doors = 1
    @State private var windows = 1
    @State private var coats = 2
    @State private var includeCeiling = false
    @State private var pricePerGallon = 0.0

    /// متوسط تغطية الدهان: ١٠ م² لكل لتر للوجه الواحد.
    private let coveragePerLiter = 10.0
    private let doorArea = 1.9              // م²
    private let windowArea = 1.5
    private let litersPerGallon = 3.785

    private var wallArea: Double {
        let walls = 2 * (length + width) * height
        let ceiling = includeCeiling ? length * width : 0
        let openings = Double(doors) * doorArea + Double(windows) * windowArea
        return max(walls + ceiling - openings, 0)
    }

    private var liters: Double {
        wallArea * Double(coats) / coveragePerLiter
    }

    private var gallons: Double { liters / litersPerGallon }

    private var totalCost: Double { gallons.rounded(.up) * pricePerGallon }

    var body: some View {
        Form {
            Section("أبعاد الغرفة (بالمتر)") {
                stepperRow("الطول", value: $length)
                stepperRow("العرض", value: $width)
                stepperRow("الارتفاع", value: $height)
                Toggle("أدهن السقف أيضاً", isOn: $includeCeiling)
            }

            Section("ما لا يُدهن") {
                Stepper("عدد الأبواب: \(doors)", value: $doors, in: 0...10)
                Stepper("عدد النوافذ: \(windows)", value: $windows, in: 0...10)
            }

            Section {
                Stepper("عدد الأوجه: \(coats)", value: $coats, in: 1...4)
            } footer: {
                Text("وجهان هو المعتاد. اجعلها ثلاثة إذا كنت تدهن لوناً فاتحاً فوق لون غامق.")
            }

            Section("النتيجة") {
                resultRow("المساحة المطلوب دهنها", String(format: "%.1f م²", wallArea))
                resultRow("كمية الدهان", String(format: "%.1f لتر", liters))
                resultRow("بالجالون", String(format: "%.1f جالون", gallons))
                resultRow("اشترِ", "\(Int(gallons.rounded(.up))) جالون", emphasized: true)
            }

            Section("التكلفة (اختياري)") {
                HStack {
                    Text("سعر الجالون")
                    Spacer()
                    TextField("0", value: $pricePerGallon, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 90)
                }
                if pricePerGallon > 0 {
                    resultRow("التكلفة التقريبية", String(format: "%.0f", totalCost), emphasized: true)
                }
            }

            Section {
                Text("""
                الحساب مبني على تغطية ١٠ م² لكل لتر في الوجه الواحد، وهو المتوسط المكتوب على أغلب العلب. \
                الجدار الخشن أو غير المعجون يشرب أكثر، فزد ١٥٪ احتياطاً.
                """)
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("حاسبة الدهان")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func stepperRow(_ title: String, value: Binding<Double>) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(String(format: "%.1f", value.wrappedValue))
                .foregroundStyle(.secondary)
                .monospacedDigit()
            Stepper(title, value: value, in: 1...20, step: 0.5)
                .labelsHidden()
        }
    }

    private func resultRow(_ title: String, _ value: String, emphasized: Bool = false) -> some View {
        HStack {
            Text(title)
                .font(emphasized ? .body.weight(.semibold) : .body)
            Spacer()
            Text(value)
                .font(emphasized ? .title3.bold() : .body)
                .foregroundStyle(emphasized ? .primary : .secondary)
                .monospacedDigit()
        }
    }
}
