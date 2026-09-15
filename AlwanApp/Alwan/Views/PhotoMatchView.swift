import SwiftUI
import PhotosUI
import UIKit

/// التقط لوناً من صورة جدار أو قماش، وجد أقرب ألوان الكتالوج إليه.
struct PhotoMatchView: View {
    @State private var item: PhotosPickerItem?
    @State private var image: UIImage?
    @State private var picked: (r: Int, g: Int, b: Int)?
    @State private var tapPoint: CGPoint?

    private var matches: [(color: PaintColor, delta: Double)] {
        guard let picked else { return [] }
        return ColorCatalog.nearest(to: LabColor(r: picked.r, g: picked.g, b: picked.b))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                if let image {
                    imageCanvas(image)
                } else {
                    placeholder
                }

                PhotosPicker(selection: $item, matching: .images, photoLibrary: .shared()) {
                    Label(image == nil ? "اختر صورة" : "غيّر الصورة", systemImage: "photo.on.rectangle.angled")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)

                if let picked {
                    pickedSwatch(picked)
                    matchList
                }

                Spacer(minLength: 20)
            }
            .padding(.top, 10)
        }
        .navigationTitle("لون من صورة")
        .navigationBarTitleDisplayMode(.inline)
        .task(id: item) { await load(item) }
    }

    // MARK: - أجزاء الواجهة

    private var placeholder: some View {
        VStack(spacing: 10) {
            Image(systemName: "eyedropper.halffull")
                .font(.system(size: 42))
                .foregroundStyle(.tint)
            Text("صوّر جدارك أو قطعة قماش، ثم اضغط على الصورة لالتقاط اللون.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(.background.secondary, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal)
    }

    private func imageCanvas(_ image: UIImage) -> some View {
        GeometryReader { geo in
            let rect = fittedRect(imageSize: image.size, in: geo.size)
            ZStack(alignment: .topLeading) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width, height: geo.size.height)

                if let tapPoint {
                    Circle()
                        .strokeBorder(.white, lineWidth: 3)
                        .background(Circle().strokeBorder(.black.opacity(0.6), lineWidth: 5))
                        .frame(width: 26, height: 26)
                        .position(tapPoint)
                        .allowsHitTesting(false)
                }
            }
            .contentShape(.rect)
            .onTapGesture(coordinateSpace: .local) { location in
                guard rect.contains(location) else { return }
                let relX = (location.x - rect.minX) / rect.width
                let relY = (location.y - rect.minY) / rect.height
                if let rgb = image.pixelColor(atRelative: CGPoint(x: relX, y: relY)) {
                    picked = rgb
                    tapPoint = location
                }
            }
        }
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(.horizontal)
        .overlay(alignment: .bottom) {
            if picked == nil {
                Text("اضغط على المكان الذي تريد لونه")
                    .font(.caption.weight(.medium))
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(.ultraThinMaterial, in: Capsule())
                    .padding(.bottom, 10)
            }
        }
    }

    private func pickedSwatch(_ rgb: (r: Int, g: Int, b: Int)) -> some View {
        let hex = String(format: "%02X%02X%02X", rgb.r, rgb.g, rgb.b)
        return HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(hex: hex))
                .frame(width: 58, height: 58)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(.primary.opacity(0.12), lineWidth: 1)
                )
            VStack(alignment: .leading, spacing: 3) {
                Text("اللون الملتقط").font(.subheadline.weight(.semibold))
                Text("#\(hex)")
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .textSelection(.enabled)
            }
            Spacer()
        }
        .padding()
        .background(.background.secondary, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .padding(.horizontal)
    }

    private var matchList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("أقرب الألوان عندنا")
                .font(.headline)
                .padding(.horizontal)

            ForEach(matches, id: \.color.id) { match in
                NavigationLink(value: match.color) {
                    HStack {
                        ColorCard(color: match.color)
                        Text(match.delta < 3 ? "مطابق" : match.delta < 8 ? "قريب جداً" : "قريب")
                            .font(.caption2.weight(.semibold))
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(.tint.opacity(0.16), in: Capsule())
                    }
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
                Divider().padding(.horizontal)
            }
        }
    }

    // MARK: - تحميل الصورة

    private func load(_ item: PhotosPickerItem?) async {
        guard let item else { return }
        if let data = try? await item.loadTransferable(type: Data.self),
           let uiImage = UIImage(data: data) {
            // نُعيد رسمها بالاتجاه الصحيح، وإلا جاء اللون من مكان غير الذي ضغط عليه المستخدم.
            image = uiImage.normalizedOrientation()
            picked = nil
            tapPoint = nil
        }
    }

    /// مستطيل الصورة الفعلي داخل الإطار بعد scaledToFit.
    private func fittedRect(imageSize: CGSize, in container: CGSize) -> CGRect {
        guard imageSize.width > 0, imageSize.height > 0 else { return .zero }
        let scale = min(container.width / imageSize.width, container.height / imageSize.height)
        let size = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        return CGRect(
            x: (container.width - size.width) / 2,
            y: (container.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
    }
}

extension UIImage {
    /// تعيد رسم الصورة باتجاه `.up` حتى تتطابق إحداثيات اللمس مع بكسلات `cgImage`.
    func normalizedOrientation() -> UIImage {
        guard imageOrientation != .up else { return self }
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }

    /// يقرأ متوسط لون مربع صغير حول النقطة (نسبة من ٠ إلى ١) لتقليل أثر التشويش.
    func pixelColor(atRelative point: CGPoint) -> (r: Int, g: Int, b: Int)? {
        guard let cg = cgImage else { return nil }
        let w = cg.width, h = cg.height
        let px = Int(point.x * CGFloat(w))
        let py = Int(point.y * CGFloat(h))
        let radius = max(2, min(w, h) / 120)

        let x0 = max(0, px - radius), y0 = max(0, py - radius)
        let x1 = min(w, px + radius + 1), y1 = min(h, py + radius + 1)
        guard x1 > x0, y1 > y0 else { return nil }

        let sampleW = x1 - x0, sampleH = y1 - y0
        var buffer = [UInt8](repeating: 0, count: sampleW * sampleH * 4)

        guard let context = CGContext(
            data: &buffer,
            width: sampleW,
            height: sampleH,
            bitsPerComponent: 8,
            bytesPerRow: sampleW * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else { return nil }

        context.draw(cg, in: CGRect(x: -x0, y: -(h - y1), width: w, height: h))

        var rt = 0, gt = 0, bt = 0
        let count = sampleW * sampleH
        for i in 0 ..< count {
            rt += Int(buffer[i * 4])
            gt += Int(buffer[i * 4 + 1])
            bt += Int(buffer[i * 4 + 2])
        }
        return (rt / count, gt / count, bt / count)
    }
}
