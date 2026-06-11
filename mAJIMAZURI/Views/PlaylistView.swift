import SwiftUI

struct PlaylistView: View {
    @State var searchResults: [Song] = []
    @State var searchQuery = ""
    @State var isSearching = false
    @ObservedObject var store: PlaylistStore
    @ObservedObject var favoritesStore: FavoritesStore

    var body: some View {
        List {
            if !searchResults.isEmpty {
                Section("iTunes Results") {
                    ForEach(searchResults, id: \.id) { song in
                        NavigationLink(destination: SongDetailView(song: song)) {
                            HStack(spacing: 12) {
                                AsyncImage(url: song.uRIimage) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 55, height: 55)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(song.title)
                                        .font(.headline)
                                    Text(song.artist)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                // Heart button for search results
                                Button {
                                    favoritesStore.toggle(song: song)
                                } label: {
                                    Image(systemName: favoritesStore.isFavorite(songId: song.id) ? "heart.fill" : "heart")
                                        .foregroundColor(favoritesStore.isFavorite(songId: song.id) ? .red : .gray)
                                }
                                .buttonStyle(.plain)
                                
                                // Add to playlist button
                                Button {
                                    store.playlist.addSong(song)
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            
            Section(searchResults.isEmpty ? "All Tracks" : "Your Playlist") {
                ForEach(
                    store.playlist.songs.compactMap { $0 as? Song },
                    id: \.id
                ) { song in
                    NavigationLink(destination: SongDetailView(song: song)) {
                        HStack(spacing: 12) {
                            AsyncImage(url: song.uRIimage) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 55, height: 55)
                            .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(song.title)
                                    .font(.headline)
                                Text(song.artist)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // Heart button for playlist songs
                            Button {
                                favoritesStore.toggle(song: song)
                            } label: {
                                Image(systemName: favoritesStore.isFavorite(songId: song.id) ? "heart.fill" : "heart")
                                    .foregroundColor(favoritesStore.isFavorite(songId: song.id) ? .red : .gray)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .onDelete { store.playlist.removeSongs(at: $0) }
                .onMove { store.playlist.moveSongs(from: $0, to: $1) }
            }
        }
        .searchable(text: $searchQuery, prompt: "Search iTunes")
        .onSubmit(of: .search) {
            Task {
                isSearching = true
                searchResults = await iTunesHelper.searchSongs(query: searchQuery)
                isSearching = false
            }
        }
        .onChange(of: searchQuery) {
            if searchQuery.isEmpty {
                searchResults = []
            }
        }
        .overlay {
            if isSearching {
                ProgressView("Searching iTunes...")
            }
        }
        .onAppear {
            guard store.playlist.songs.isEmpty else { return }
            
            // Load local JSON first
            let localSongs = JSONHelper.loadSongs()
            for song in localSongs {
                store.playlist.addSong(song)
            }
            
            // Then fetch from iTunes
            Task {
                async let afro = iTunesHelper.searchSongs(query: "Afrobeats")
                async let rnb = iTunesHelper.searchSongs(query: "RnB")
                let results = await afro + rnb
                for song in results {
                    store.playlist.addSong(song)
                }
            }
        }
        .navigationTitle("All tracks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaylistView(store: PlaylistStore(), favoritesStore: FavoritesStore())
    }
}
