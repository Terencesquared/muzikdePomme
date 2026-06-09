import SwiftUI

struct PlaylistView: View {
    @State var playlist = Playlist(name: "Banana")
    
    var body: some View {
       
        List(playlist.songs, id: \.title) { song in
            HStack (spacing: 12){
                AsyncImage(url: song.uRIimage) { image in
                    image.resizable()
                        .scaledToFit()
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
                    
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                    
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("All tracks")
        .onAppear {
                let song1 = Song(
                    title: "Essence",
                    artist: "Wizzkid",
                    album:"Made in Lagos" ,
                    duration: 214,
                    genre: .classical,
                    path: "songs/essence.mp3",
                    uRIimage: URL(string: "https://i.ytimg.com/vi/0o7dQcLd_cY/maxresdefault.jpg")!
                )
                let song2 = Song(
                    title: "Softly",
                    artist: "Cruel Santino",
                    album:"Subaru boys" ,
                    duration: 214,
                    genre: .classical,
                    path:"songs/softly.mp3" ,
                    uRIimage: URL(string: "https://i.ytimg.com/vi/0o7dQcLd_cY/maxresdefault.jpg")!
                )
                //create a playlist
                //var myPlaylist = Playlist(name: "Banana")
                playlist.addSong(song1)
                playlist.addSong(song2)
                //self.myPlaylist = myPlaylist
                
                //test the functions
                print("Playlist: \(playlist.name)")
                print("Total duration: \(playlist.totalDuration()) seconds")
                print ("Songs by Wizkid: \(playlist.findSong(byArtist:"Wizzkid").count)")
                
                if let found = playlist.searchSong(named: "Softly") {
                    print("Found: \(found.title) by \(found.getAuthor())")
                    print("Duration: \(found.getPlayingTime())")
                    
                }
            }
        }
            
                
                
               
    }

#Preview {
    PlaylistView()
}
