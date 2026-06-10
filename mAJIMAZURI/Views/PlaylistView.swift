import SwiftUI

struct PlaylistView: View {
    @State var searchQuery = ""
    @State var isSearching = false
    @State var playlist = SampleData.playlist

    var body: some View {
        List {
            ForEach(playlist.songs.compactMap { $0 as? Song }, id: \.id)  { song in
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

                        Button {
                            //code for the button functionality
                            playlist.toggleFavorite(songId: song.id)} label: {
                                Image(systemName: playlist.isFavorite(songId: song.id) ? "heart.fill" : "heart")
                                    .foregroundColor(playlist.isFavorite(songId: song.id) ? .red: .gray)
                                    
                            }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 4)
                }
            }
            .onDelete { playlist.removeSongs(at: $0) }
            .onMove { playlist.moveSongs(from: $0, to: $1) }
        }                                          // ← List closes here
        .searchable(text: $searchQuery, prompt: "Search iTunes")
        .onSubmit(of: .search) {
            Task {
                isSearching = true
                let results = await iTunesHelper.searchSongs(query: searchQuery)
                for song in results {
                    playlist.addSong(song)
                }
                isSearching = false
            }
        }
        .overlay {
            if isSearching {
                ProgressView("Searching iTunes...")
            }
        }
        .navigationTitle(playlist.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}

#Preview {
    NavigationStack {
        PlaylistView()
    }
}
