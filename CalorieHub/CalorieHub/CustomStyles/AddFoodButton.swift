//
//  AddFoodButtom.swift
//  CalorieHub
//
//  Created by Kein Li on 12/30/23.
//

import SwiftUI

struct AddFoodButton: View {
    var body: some View {
        Text("Add")
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 48)
            .foregroundStyle(.white)
            .background(.orange).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .clipShape(Capsule())
            .padding(20)
        
    }
}

#Preview {
    AddFoodButton()
}
