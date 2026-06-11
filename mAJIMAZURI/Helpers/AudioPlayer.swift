import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
    @Published var isPlaying = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    func play(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        stop()
        
        player = AVPlayer(url: url)
        
        // Load duration async
        Task {
            do {
                let duration = try await player?.currentItem?.asset.load(.duration)
                await MainActor.run {
                    let seconds = duration?.seconds ?? 0
                    if seconds.isFinite { self.duration = seconds }
                }
            } catch {
                print("Duration load error: \(error)")
            }
        }
        
        // Update progress every 0.1 seconds
        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.1, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time.seconds
            if self?.currentTime ?? 0 >= self?.duration ?? 0 {
                self?.stop()
            }
        }
        
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        isPlaying = false
    }
    
    func stop() {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
        player?.pause()
        player = nil
        isPlaying = false
        currentTime = 0
        duration = 0
    }
    
    func seek(to time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: 600))
    }
}
