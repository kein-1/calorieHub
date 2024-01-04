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
        
        ZStack {
            Circle()
                .stroke(
                    .orange.opacity(0.5),
                    lineWidth: 20)
                .padding()
            
            if let remainingCalories {
                Text(remainingCalories.formatted())
                    .font(.system(size: 30))
            }
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    .orange,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .padding()
                .rotationEffect(.degrees(-90))
        }
        .animation(.easeInOut, value: progress)
    }
}

//#Preview {
//    CircularProgressView()
//}
