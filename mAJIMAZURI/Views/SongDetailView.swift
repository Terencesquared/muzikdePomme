import SwiftUI
import AVFoundation

struct SongDetailView: View {
    let song: Song
    @StateObject private var audioPlayer = AudioPlayer()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: song.uRIimage) { image in
                    image.resizable().scaledToFit()
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
                
                HStack(spacing: 40) {
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
                        Text(song.genre.rawValue)
                            .font(.headline)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // MARK: - Progress bar
                VStack(spacing: 8) {
                    Slider(
                        value: $audioPlayer.currentTime,
                        in: 0...max(audioPlayer.duration, 1),
                        onEditingChanged: { scrubbing in
                            if !scrubbing {
                                audioPlayer.seek(to: audioPlayer.currentTime)
                            }
                        }
                    )
                    .accentColor(.accentColor)
                    
                    HStack {
                        Text(formatTime(audioPlayer.currentTime))
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(formatTime(audioPlayer.duration))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Play/Pause button
                Button {
                    if audioPlayer.isPlaying {
                        audioPlayer.pause()
                    } else {
                        audioPlayer.play(urlString: song.path)
                    }
                } label: {
                    Image(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
        .navigationTitle(song.title)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            audioPlayer.stop()  // stop audio when leaving the view
        }
    }
    
    // Formats seconds into m:ss
    func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite else { return "0:00" }
        let m = Int(seconds) / 60
        let s = Int(seconds) % 60
        return "\(m):\(String(format: "%02d", s))"
    }
}
