//
//  SongProtocol.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import Foundation

protocol SongProtocol {
    var title: String { get }
    var artist: String { get }
    var album: String { get }
    var duration: TimeInterval { get }
    var path: String { get }
    func getAuthor () -> String
    func getPlayingTime () -> String
    var uRIimage: URL { get }
}
