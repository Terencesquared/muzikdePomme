//
//  PlaylistProtocol.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import Foundation

protocol PlaylistProtocol {
    var name: String { get }
    var songs: [any SongProtocol] { get set}
    
    mutating func addSong(_ song: any SongProtocol)
    mutating func removeSong(named title: String)
    mutating func removeSongs(at offsets: IndexSet)
    mutating func moveSongs(from source: IndexSet, to destination: Int)
    func searchSong(named title: String) -> (any SongProtocol)?
    func findSong(byArtist artist: String) -> [any SongProtocol]
    func totalDuration() -> Double
}
