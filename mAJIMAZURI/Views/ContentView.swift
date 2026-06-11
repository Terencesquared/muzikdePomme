//
//  ContentView.swift
//  mAJIMAZURI
//
//  Created by etud on 08/06/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store = PlaylistStore()
    @StateObject var favoritesStore = FavoritesStore()
    
    var body: some View {
        TabView {
            NavigationStack {
                PlaylistView(store: store, favoritesStore: favoritesStore)
            }
            .tabItem {
                Label("All", systemImage: "music.note.list")
            }
            
            NavigationStack {
                FavoritesView(favoritesStore: favoritesStore)
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
