//
//  JSONHelper.swift
//  mAJIMAZURI
//
//  Created by etud on 10/06/2026.
//

import Foundation
 struct JSONHelper {
     static func loadSongs() -> [Song] {
         guard let url =
                Bundle.main.url(forResource: "songs",
                                withExtension: "json"),
               let data = try?
                Data(contentsOf: url) else {
             print("Could not find songs.son")
             return []
         }
         let decoder = JSONDecoder()
         guard let songs = try?
                decoder.decode([Song].self, from: data) else {
             print("Could not decode songs.json")
             return []
         }
         return songs
     }
}
