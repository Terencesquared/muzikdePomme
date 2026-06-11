import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesStore: FavoritesStore
    
    var body: some View {
        List {
            ForEach(favoritesStore.favoriteSongs, id: \.id) { song in
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
                            favoritesStore.toggle(song: song)
                        } label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.vertical, 4)
                }
            }
            .onMove { favoritesStore.move(from: $0, to: $1) }
            .onDelete { favoritesStore.remove(at: $0) }
        }
        .navigationTitle("Favorites")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .overlay {
            if favoritesStore.favoriteSongs.isEmpty {
                ContentUnavailableView(
                    "No Favorites Yet",
                    systemImage: "heart.slash",
                    description: Text("Tap the heart on any song to save it here")
                )
            }
        }
    }
}

#Preview {
    FavoritesView(favoritesStore: FavoritesStore())
}
