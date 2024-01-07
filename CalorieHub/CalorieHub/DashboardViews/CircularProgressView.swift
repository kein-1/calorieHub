//
//  CircularProgressView.swift
//  CalorieHub
//
//  Created by Kein Li on 1/4/24.
//

import SwiftUI

struct CircularProgressView : View {
    
    var progress : Double
    var remainingCalories : Int?
    
    var body : some View {
        
        Circle()
            .stroke(
                .orange.opacity(0.5),
                lineWidth: 12)
            .overlay {
            
            if let remainingCalories {
                VStack {
                    Text(remainingCalories.formatted())
                        .font(.system(size: 24))
                    Text("kCal left")
                        .font(.subheadline)
                }
//                .foregroundStyle(.orange)
            }
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    .orange,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
        .padding()
        .frame(maxWidth: 150)
        .animation(.easeInOut, value: progress)
    }
}
//
//#Preview {
//    CircularProgressView(progress: 800, remainingCalories: 150)
//}
//
