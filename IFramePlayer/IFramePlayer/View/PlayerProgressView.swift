//
//  PlayerProgressView.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 17.01.2024.
//

import SwiftUI

struct PlayerProgressView: View {
    
    @State var text: String
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            
            Text(text.capitalized)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    PlayerProgressView(text: "Buffering...")
        .padding()
        .background(.black)
}
