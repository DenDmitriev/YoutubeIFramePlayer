//
//  TimelineSlider.swift
//  IFramePlayer
//
//  Created by Denis Dmitriev on 17.01.2024.
//

import SwiftUI

struct TimelineSlider: View {
    static let heightLine: CGFloat = 4
    @Binding var playhead: Double
    @Binding var range: ClosedRange<Double>
    var onTabAction: ((Double) -> Void)
    
    var body: some View {
        GeometryReader { geometry in
            let stepX = geometry.size.width / (range.upperBound - range.lowerBound)
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Self.heightLine / 2)
                    .fill(.placeholder)
                    .frame(height: Self.heightLine)
                
                let widthProgress = stepX * playhead
                RoundedRectangle(cornerRadius: Self.heightLine / 2)
                    .fill(Color.accentColor)
                    .frame(height: Self.heightLine)
                    .frame(width: widthProgress)
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            .onTapGesture(coordinateSpace: .local) { location in
                let locationX = min(max(0, location.x), geometry.size.width)
                let newValue = min(range.lowerBound + locationX / stepX, range.upperBound)
                onTabAction(newValue)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var postion: Double = 20.0
        @State var range = 0.0...60.0
        
        var body: some View {
            TimelineSlider(playhead: $postion, range: $range) { newPosition in
                print(newPosition)
            }
        }
    }
   
    return PreviewWrapper()
        .frame(width: 400, height: 50)
        .padding()
}
