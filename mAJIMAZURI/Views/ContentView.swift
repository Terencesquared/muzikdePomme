//
//  ContentView.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                PlaylistView()
            }
            .tabItem {
                Label("All", systemImage: "music.note.list")
            }
            
            NavigationStack {
                Text("Favorites coming soon")
            }
             .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
