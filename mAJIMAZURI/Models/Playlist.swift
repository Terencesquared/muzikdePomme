//
//  Playlist.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import Foundation
struct Playlist: PlaylistProtocol {
    var favoriteSongIds: Set<UUID> = []
    
    mutating func toggleFavorite(songId: UUID) {
        if favoriteSongIds.contains(songId) {
            favoriteSongIds.remove(songId)
        } else {
            favoriteSongIds.insert(songId)
        }
    }
    func isFavorite(songId: UUID) -> Bool {
        return favoriteSongIds.contains(songId)
    }
    var favoriteSongs: [any SongProtocol] {
        songs.filter { song in
            guard let s = song as? Song else
            {return false}
            return favoriteSongIds.contains(s.id)
        }
    }
    var name: String
    var songs: [any SongProtocol] = []
    mutating func addSong(_ song: any SongProtocol) {
        guard !songs.contains(where: { $0.title == song.title && $0.artist == song.artist }) else { return }
        songs.append(song)
    }
    mutating func removeSongs(at offsets: IndexSet)
    {
        songs.remove(atOffsets: offsets)
    }
    mutating func moveSongs(from source: IndexSet, to destination: Int){
        songs.move(fromOffsets: source, toOffset: destination)
    }
    mutating func removeSong(named name: String) {
        songs.removeAll {
            $0.title == name
        }
        }
    func searchSong(named title: String) -> (any SongProtocol)?{
        return songs.first {
            $0.title == title
        }
        
    }
    func findSong(byArtist artist: String) -> [any SongProtocol] {
        return songs.filter {$0.artist == artist }
    }
    func totalDuration() -> Double {
        return songs.reduce(0) { $0 + $1.duration }
    }
    }

