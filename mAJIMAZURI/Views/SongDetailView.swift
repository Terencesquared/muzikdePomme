//
//  SongDetailView.swift
//  mAJIMAZURI
//
//  Created by etud on 10/06/2026.
//

import Foundation
import SwiftUI

struct SongDetailView: View {
    let song: Song
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                AsyncImage(url: song.uRIimage) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 250, height: 250)
                .cornerRadius(16)
                .shadow(radius: 10)
                
                
                VStack(spacing: 8) {
                    Text(song.title)
                        .font(.title)
                        .bold()
                    Text(song.artist)
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text(song.album)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                HStack(spacing: 40){
                    VStack {
                        Text("Duration")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(song.getPlayingTime())
                            .font(.headline)
                    }
                    VStack {
                        Text("Genre")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(song.genre.rawValue)")
                            .font(.headline)
                        
                        
                    }
                    
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
            }
            .padding()
        }
        .navigationTitle(song.title)
        .navigationBarTitleDisplayMode(.inline)
        
        
        
        
    }
    
    
    
    
    
}
    
