//
//  FavoritesStore.swift
//  mAJIMAZURI
//
//  Created by etud on 11/06/2026.
//


import Foundation

class FavoritesStore: ObservableObject {
    @Published var favoriteSongs: [Song] = [] {
        didSet { save() }
    }
    
    private let fileName = "favorites.json"
    
    init() { load() }
    
    // MARK: - Public methods
    func toggle(song: Song) {
        if isFavorite(songId: song.id) {
            favoriteSongs.removeAll { $0.id == song.id }
        } else {
            favoriteSongs.append(song)
        }
    }
    
    func isFavorite(songId: UUID) -> Bool {
        favoriteSongs.contains { $0.id == songId }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        favoriteSongs.move(fromOffsets: source, toOffset: destination)
    }
    
    func remove(at offsets: IndexSet) {
        favoriteSongs.remove(atOffsets: offsets)
    }
    
    // MARK: - JSON persistence
    private func fileURL() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(favoriteSongs)
            try data.write(to: fileURL())
            print("Favorites saved to \(fileURL())")
        } catch {
            print("Failed to save favorites: \(error)")
        }
    }
    
    private func load() {
        do {
            let data = try Data(contentsOf: fileURL())
            favoriteSongs = try JSONDecoder().decode([Song].self, from: data)
            print("Loaded \(favoriteSongs.count) favorites")
        } catch {
            print("No favorites file yet or failed to load: \(error)")
            favoriteSongs = []
        }
    }
}
