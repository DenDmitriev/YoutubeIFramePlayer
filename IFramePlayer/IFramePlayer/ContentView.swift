//
//  ContentView.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 16.01.2024.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct ContentView: View {
    @StateObject var youtubePlayerViewModel = YoutubePlayerViewModel()
    
    var body: some View {
        YoutubePlayer(viewModel: youtubePlayerViewModel)
    }
}

#Preview {
    ContentView()
}
