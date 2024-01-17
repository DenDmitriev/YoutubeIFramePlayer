//
//  YouTubeView.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 16.01.2024.
//

import Cocoa
import SwiftUI
import YouTubeiOSPlayerHelper

struct YoutubeView: NSViewRepresentable {
    typealias NSViewType = YTPlayerView
    
    @Binding var url: URL?
    var coordinator: YoutubePlayerViewModel
    
    static var placeholder: NSTextView = {
        let label = NSTextView()
        label.textColor = .placeholderTextColor
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.string = "Video is empty"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alignment = .center
        return label
    }()
    
    func makeNSView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.delegate = coordinator
        coordinator.playerView = playerView
        return playerView
    }
    
    func updateNSView(_ nsView: YTPlayerView, context: Context) {
        guard let videoId = videoId(from: url)
        else {
            setPlaceholder(nsView)
            nsView.presentError(YTPlayerError.videoNotFound)
            return
        }
        nsView.load(withVideoId: videoId)
    }
    
    static func dismantleNSView(_ nsView: YTPlayerView, coordinator: YoutubePlayerViewModel) {
//        print(#function)
    }
    
    func makeCoordinator() -> YoutubePlayerViewModel {
        return coordinator
    }
    
    private func videoId(from url: URL?) -> String? {
        guard let url else { return nil }
        let host = url.host
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if host == "youtu.be" {
            return url.pathComponents[1]
        } else if url.absoluteString.contains("www.youtube.com/embed") {
            return url.pathComponents[2]
        } else if host == "youtube.googleapis.com" || url.pathComponents.first! == "www.youtube.com" {
            return url.pathComponents[2]
        } else if let query = urlComponents?.queryItems, let videoIdQuery = query.first(where: { $0.name == "v" }) {
            return videoIdQuery.value
        } else {
            return nil
        }
    }
    
    private func setPlaceholder(_ nsView: NSView) {
        let placeholder = Self.placeholder
        nsView.addSubview(placeholder)
        NSLayoutConstraint.activate([
            placeholder.widthAnchor.constraint(equalTo: nsView.widthAnchor, multiplier: 1),
            placeholder.centerXAnchor.constraint(equalTo: nsView.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: nsView.centerYAnchor)
        ])
    }
}
