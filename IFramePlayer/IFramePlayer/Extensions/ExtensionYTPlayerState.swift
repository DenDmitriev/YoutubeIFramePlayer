//
//  ExtensionYTPlayerState.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 17.01.2024.
//

import YouTubeiOSPlayerHelper

extension YTPlayerState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unstarted:
            return "unstarted"
        case .ended:
            return "ended"
        case .playing:
            return "playing"
        case .paused:
            return "paused"
        case .buffering:
            return "buffering..."
        case .cued:
            return "cued"
        case .unknown:
            return "unknown"
        @unknown default:
            return "unknown"
        }
    }
}
