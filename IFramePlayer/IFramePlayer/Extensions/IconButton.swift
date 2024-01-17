//
//  IconButton.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 17.01.2024.
//

import SwiftUI

struct IconButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .foregroundStyle(.secondary)
            .font(.title2.weight(.semibold))
            .frame(width: 28, height: 20)
    }
}

extension ButtonStyle where Self == IconButton {
    static var icon: IconButton { .init() }
}

#Preview("CircleButton") {
    struct PreviewWrapper: View {
        var body: some View {
            HStack {
                Button(action: {
                    print("Button pressed!")
                }, label: {
                    Image(systemName: "play.fill")
                })
                
                Button(action: {
                    print("Button pressed!")
                }, label: {
                    Image(systemName: "pause.fill")
                })
            }
            
            .buttonStyle(.icon)
            .frame(maxWidth: 100, maxHeight: 100)
            .background(.background)
        }
    }
    
    return VStack(spacing: .zero) {
        PreviewWrapper()
            .environment(\.colorScheme, .light)
        
        PreviewWrapper()
            .environment(\.colorScheme, .dark)
    }
}
