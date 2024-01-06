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
                    lineWidth: 10)
                .padding()
            
            if let remainingCalories {
                VStack {
                    Text(remainingCalories.formatted())
                        .font(.title)
                    Text("kCal left")
                        .font(.subheadline)
                }
            }
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    .orange,
                    style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .padding()
                .rotationEffect(.degrees(-90))
        }
        .border(.blue)
        .frame(maxWidth: 200)
        .animation(.easeInOut, value: progress)
    }
}

//#Preview {
//    CircularProgressView()
//}
