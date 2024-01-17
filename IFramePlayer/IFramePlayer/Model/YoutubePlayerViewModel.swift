//
//  PlayerDelegate.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 16.01.2024.
//

import Foundation
import YouTubeiOSPlayerHelper

class YoutubePlayerViewModel: NSObject, ObservableObject {
    weak var playerView: YTPlayerView?
    @Published var isReady: Bool = false
    @Published var state: YTPlayerState = .unstarted
    @Published var quality: YTPlaybackQuality = .unknown
    @Published var error: PlayerError?
    @Published var hasError: Bool = false
    @Published var playhead: Double = .zero
    @Published var duration: Double?
    @Published var videoRange: ClosedRange<Double> = 0.0...1.0
    
    private func presentError(error: PlayerError) {
        DispatchQueue.main.async {
            self.error = error
            self.hasError = true
        }
    }
}

extension YoutubePlayerViewModel: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        isReady = true
        playerView.duration { [weak self] duration, error in
            if let error = error as? YTPlayerError {
                self?.presentError(error: .ytPlayerError(error: error))
            } else {
                self?.videoRange = 0.0...duration
                self?.duration = duration
            }
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        self.state = state
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
        self.quality = quality
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        playhead = Double(playTime)
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        presentError(error: .ytPlayerError(error: error))
    }
}
