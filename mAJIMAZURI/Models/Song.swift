import Foundation

struct Song: SongProtocol, Codable, Identifiable {
    let id: UUID
    let title: String
    let artist: String
    let album: String
    let duration: TimeInterval
    let genre: Genre
    let path: String
    let uRIimage: URL
    
    // Auto-generate id if not present in JSON
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decode(UUID.self, forKey: .id)) ?? UUID()
        title = try container.decode(String.self, forKey: .title)
        artist = try container.decode(String.self, forKey: .artist)
        album = try container.decode(String.self, forKey: .album)
        duration = try container.decode(TimeInterval.self, forKey: .duration)
        genre = try container.decode(Genre.self, forKey: .genre)
        path = try container.decode(String.self, forKey: .path)
        uRIimage = try container.decode(URL.self, forKey: .uRIimage)
    }
    
    // Normal init for creating songs in code
    init(id: UUID = UUID(), title: String, artist: String, album: String,
         duration: TimeInterval, genre: Genre, path: String, uRIimage: URL) {
        self.id = id
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.genre = genre
        self.path = path
        self.uRIimage = uRIimage
    }
    
    func getAuthor() -> String { artist }
    
    func getPlayingTime() -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return "\(minutes):\(String(format: "%02d", seconds))"
    }
}
