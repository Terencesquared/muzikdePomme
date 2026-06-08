//
//  Playlist.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import Foundation
struct Playlist: PlaylistProtocol {
    var name: String
    var songs: [any SongProtocol] = []
    mutating func addSong(_ song: any SongProtocol) {
        songs.append(song)
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

