//
//  ProgressCircle.swift
//  DoThingsSwiftUI
//
//  Created by Aditya Cahyo on 10/04/22.
//

import SwiftUI

struct GaugeProgressStyle: ProgressViewStyle {
    var strokeWidth = 25.0
    
    var progress: Double
    var total: Double
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack {
            let percentage: Int = Int(progress / total * 100)
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(percentage >= 50 ? .blue : .orange, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(90))
            Text("\(percentage) %")
                .bold()
                .font(.largeTitle)
        }
    }
}

struct ProgressCircle: View {
    var progress: Double
    var total: Double
    
    var body: some View {
        ProgressView(value: progress, total: total)
            .progressViewStyle(GaugeProgressStyle(progress: progress, total: total))
            .frame(width: 175, height: 175)
            .padding(.top, 5)
            .padding(.bottom, 20)
            .animation(.easeInOut(duration: 1), value: total)
    }
}
