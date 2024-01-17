//
//  YoutubePlayer.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 17.01.2024.
//


import SwiftUI
import YouTubeiOSPlayerHelper

struct YoutubePlayer: View {
    @ObservedObject var viewModel: YoutubePlayerViewModel
    weak var player: YTPlayerView?
    @State var url: URL? = URL(string: "https://youtu.be/dQw4w9WgXcQ")
    @State var isPLaying: Bool = false
    
    var body: some View {
        VStack {
            playerView
            
            HStack {
                Button(action: {
                    isPlaying ? viewModel.playerView?.pauseVideo() : viewModel.playerView?.playVideo()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                }
                
                Button(action: {
                    viewModel.playerView?.stopVideo()
                }) {
                    Image(systemName: "stop.fill")
                }
                
                Text(currentTime().wrappedValue.formatted(.time(pattern: .minuteSecond)))
                    .foregroundStyle(.secondary)
                
                TimelineSlider(playhead: $viewModel.playhead, range: $viewModel.videoRange) { newPlayhead in
                    viewModel.playerView?.seek(toSeconds: Float(newPlayhead), allowSeekAhead: true)
                    viewModel.state = .buffering
                    viewModel.playhead = newPlayhead
                }
                .frame(height: 8)
                .animation(.linear(duration: viewModel.state == .buffering ? 0 : 1), value: viewModel.playhead)
                
                Text(totalTime().wrappedValue.formatted(.time(pattern: .minuteSecond)))
                    .foregroundStyle(.secondary)
            }
            .disabled(url == nil)
            .buttonStyle(.icon)
            .padding()
            
            HStack {
                Label("Youtube link", systemImage: "link")
                
                TextField("Paste a link to a YouTube video", value: $url, format: .url)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 300)
                
                Spacer()
                
                Text(viewModel.state.description)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error, actions: { error in
            Button(action: {}) {
                Text("Ok")
            }
        }, message: { error in
            Text(error.failureReason ?? "Reason unknown")
        })
        .padding()
        .frame(minWidth: 600, minHeight: 400)
    }
    
    var playerView: some View {
        YoutubeView(url: $url, coordinator: viewModel)
            .overlay(content: {
                switch viewModel.state {
                case .buffering, .unknown:
                    PlayerProgressView(text: viewModel.state.description)
                default:
                    Color.clear
                }
            })
//            .allowsHitTesting(false)
    }
    
    var isPlaying: Bool {
        viewModel.state == .playing
    }
    
    func currentTime() -> Binding<Duration> {
        .init(get: { .seconds(Double(viewModel.playhead)) }) { _ in }
    }
    
    func totalTime() -> Binding<Duration> {
        .init(get: { .seconds(Double(viewModel.duration ?? .zero)) }) { _ in }
    }
}

#Preview {
    var delegate: YoutubePlayerViewModel = YoutubePlayerViewModel()
    
    return YoutubePlayer(viewModel: delegate)
}
