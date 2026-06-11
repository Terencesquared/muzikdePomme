//
//  PlaylistStore.swift
//  mAJIMAZURI
//
//  Created by etud on 11/06/2026.
//


import Foundation
import Combine

class PlaylistStore: ObservableObject {
    @Published var playlist = Playlist(name: "All Songs")
}
