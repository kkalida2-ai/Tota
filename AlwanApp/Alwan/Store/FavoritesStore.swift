import Foundation
import Observation

/// يحفظ الألوان المفضلة وخطة ألوان البيت على الجهاز نفسه (UserDefaults).
@MainActor
@Observable
final class FavoritesStore {
    private let favoritesKey = "alwan.favorites"
    private let planKey = "alwan.plan"

    private(set) var favorites: Set<String> = []

    /// اللون المختار لكل غرفة — «خطة البيت».
    private(set) var plan: [String: String] = [:]

    init() {
        let defaults = UserDefaults.standard
        favorites = Set(defaults.stringArray(forKey: favoritesKey) ?? [])
        plan = defaults.dictionary(forKey: planKey) as? [String: String] ?? [:]
    }

    func isFavorite(_ color: PaintColor) -> Bool { favorites.contains(color.id) }

    func toggleFavorite(_ color: PaintColor) {
        if favorites.contains(color.id) {
            favorites.remove(color.id)
        } else {
            favorites.insert(color.id)
        }
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }

    var favoriteColors: [PaintColor] {
        ColorCatalog.all.filter { favorites.contains($0.id) }
    }

    // MARK: - خطة البيت

    func chosenColor(for room: Room) -> PaintColor? {
        plan[room.rawValue].flatMap(ColorCatalog.color(id:))
    }

    func choose(_ color: PaintColor, for room: Room) {
        plan[room.rawValue] = color.id
        persistPlan()
    }

    func clearChoice(for room: Room) {
        plan[room.rawValue] = nil
        persistPlan()
    }

    func isChosen(_ color: PaintColor, for room: Room) -> Bool {
        plan[room.rawValue] == color.id
    }

    var plannedRooms: [(room: Room, color: PaintColor)] {
        Room.allCases.compactMap { room in
            guard let color = chosenColor(for: room) else { return nil }
            return (room, color)
        }
    }

    private func persistPlan() {
        UserDefaults.standard.set(plan, forKey: planKey)
    }
}
