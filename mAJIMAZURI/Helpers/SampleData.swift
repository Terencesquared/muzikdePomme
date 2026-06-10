//
//  SampleData.swift
//  mAJIMAZURI
//
//  Created by etud on 10/06/2026.
//


// Helpers/SampleData.swift
struct SampleData {
    static var playlist: Playlist = {
        var p = Playlist(name: "Banana")
        let songs = JSONHelper.loadSongs()
        for song in songs { p.addSong(song) }
        return p
    }()
}