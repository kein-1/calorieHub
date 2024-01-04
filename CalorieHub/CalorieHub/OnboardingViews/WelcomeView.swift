//
//  WelcomeView.swift
//  CalorieHub
//
//  Created by Kein Li on 12/24/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var selection : Int
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Welcome to")
                Text("calorieHub!")
                    .foregroundStyle(.orange)
            }
            .font(.headline)
            
            
            Image("Polarbear")
                .resizable()
                .interpolation(.high)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
            
            Text("This app is aimed to help you track your calories and reach your goals! Click the button below to begin onboarding")
                .font(.subheadline)
                .padding()
            
            Spacer()
            
            Button {
                withAnimation{
                    selection += 1
                }
            } label: {
                CustomLabel(text: "Next")
            }
        }
        .transition(.slide)
    }
}

#Preview {
    WelcomeView(selection: .constant(1))
}
