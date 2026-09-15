import SwiftUI

struct ToolsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        PhotoMatchView()
                    } label: {
                        toolRow("eyedropper.halffull", "لون من صورة",
                                "صوّر جداراً أو قماشاً، واعرف أقرب لون عندنا إليه.")
                    }
                    NavigationLink {
                        PaintCalculatorView()
                    } label: {
                        toolRow("ruler.fill", "حاسبة كمية الدهان",
                                "أدخل أبعاد الغرفة واعرف كم جالوناً تشتري.")
                    }
                    NavigationLink {
                        GuideView()
                    } label: {
                        toolRow("book.fill", "دليل الدهان",
                                "الأخطاء الشائعة وترتيب الخطوات من الاختيار حتى الوجه الأخير.")
                    }
                }
            }
            .navigationTitle("أدوات")
            .navigationDestination(for: PaintColor.self) {
                ColorDetailView(color: $0, room: $0.rooms.first)
            }
        }
    }

    private func toolRow(_ symbol: String, _ title: String, _ subtitle: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: symbol)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.tint)
                .frame(width: 34)
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.headline)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.vertical, 6)
    }
}
