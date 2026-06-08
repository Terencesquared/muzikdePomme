//
//  Song.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import Foundation
struct Song: SongProtocol {
    let title: String
    let artist: String
    let album: String
    let duration: Double
    let genre: Genre
    let path: String
    let uRIimage: URL
    
    
    func getAuthor() -> String {
        return artist
    }
    func getPlayingTime() -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return  "\(minutes):\(String(format: "%02d", seconds))"
    }
}
