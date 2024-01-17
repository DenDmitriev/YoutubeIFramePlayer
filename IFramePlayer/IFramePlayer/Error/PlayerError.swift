//
//  PlayerError.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 17.01.2024.
//

import Foundation
import YouTubeiOSPlayerHelper

enum PlayerError: Error {
    case ytPlayerError(error: YTPlayerError)
    case durationError
}

extension PlayerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .ytPlayerError(let error):
            return error.localizedDescription
        case .durationError:
            return String(localized: "Duration unknown.", comment: "Error")
        }
    }
}

extension YTPlayerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidParam:
            return String(localized: "Invalid parameter.", comment: "Error")
        case .html5Error:
            return String(localized: "HTML5 error.", comment: "Error")
        case .videoNotFound:
            return String(localized: "Video not found.", comment: "Error")
        case .notEmbeddable:
            return String(localized: "Not embeddable.", comment: "Error")
        case .unknown:
            return String(localized: "Unknown error", comment: "Error")
        @unknown default:
            return String(localized: "Unknown error", comment: "Error")
        }
    }
}
