//
//  FinishView.swift
//  CalorieHub
//
//  Created by Kein Li on 12/24/23.
//

import SwiftUI

struct FinishView: View {
    
    @Binding var isOnboarding : Bool
    
    var body: some View {
        VStack(spacing: 40) {
           
            
            Image("Orange")
                .resizable()
                .interpolation(.high)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 250)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            
            Text("Great work ! You've completed on-boarding. Click done to begin your journey!")
                .font(.subheadline)
                .padding()
            
            Spacer()
            
            Button {
                isOnboarding = false
            } label: {
                CustomLabel(text: "Done!")
            }
        }
        .transition(.slide)
    }
}

#Preview {
    FinishView(isOnboarding: .constant(false))
}
