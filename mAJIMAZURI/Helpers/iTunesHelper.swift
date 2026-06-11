import Foundation

// MARK: - DTO (what iTunes sends us)
struct iTunesTrackDTO: Codable {
    let trackName: String?
    let artistName: String?
    let collectionName: String?
    let trackTimeMillis: Int?
    let previewUrl: String?
    let artworkUrl100: String?
    
    // Convert DTO → our Song model
    func toSong() -> Song? {
        guard
            let title = trackName,
            let artist = artistName,
            let millis = trackTimeMillis,
            let imageString = artworkUrl100,
            let imageURL = URL(string: imageString)
        else { return nil }  // ← safely discard incomplete tracks
        
        return Song(
            id: UUID(),
            title: title,
            artist: artist,
            album: collectionName ?? "Unknown Album",
            duration: TimeInterval(millis / 1000),
            genre: .other,
            path: previewUrl ?? "",
            uRIimage: imageURL
        )
    }
}

struct iTunesResponseDTO: Codable {
    let results: [iTunesTrackDTO]
}

// MARK: - Helper
struct iTunesHelper {
    static func searchSongs(query: String) async -> [Song] {
        let formatted = query.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(formatted)&media=music&limit=10"
        
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(iTunesResponseDTO.self, from: data)
            return response.results.compactMap { $0.toSong() }
            //               ↑ compactMap discards any nil results safely
        } catch {
            print("iTunes fetch error: \(error)")
            return []
        }
    }
}
