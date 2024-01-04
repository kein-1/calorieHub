//
//  OnBoarding.swift
//  CalorieHub
//
//  Created by Kein Li on 12/19/23.
//

import SwiftUI

struct OnBoarding: View {
    
    @State private var selection = 0
    @Binding var isOnboarding : Bool
    
    var body: some View {
        VStack {
            Text("caloriehub")
                .font(.title)
                .foregroundStyle(.orange)
                .padding(.bottom, 15)
            
            TabView(selection: $selection) {
                WelcomeView(selection: $selection)
                    .tag(0)
                    .gesture(DragGesture()) // disables swiping
                PersonalInfoView(selection: $selection)
                    .tag(1)
                    .gesture(DragGesture())
                
                PersonalInfoMacrosView(selection: $selection)
                    .tag(2)
                    .gesture(DragGesture())
                
                FinishView(isOnboarding: $isOnboarding)
                    .tag(3)
                    .gesture(DragGesture())
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    let healthStore = HealthStore()
    return OnBoarding(isOnboarding: .constant(false))
        .environment(healthStore)
}
