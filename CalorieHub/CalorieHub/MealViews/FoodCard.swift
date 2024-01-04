//
//  FoodCard.swift
//  CalorieHub
//
//  Created by Kein Li on 12/28/23.
//

import SwiftUI

struct FoodCard: View {
    
    var category : String
    
    var body: some View {
        VStack {
            Circle()
                .overlay {
                    VStack {
                        Image(category)
                            .resizable()
                            .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 50)
                            .clipShape(Circle())
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.white)
                    }
                }
                .foregroundStyle(.orange)
            Text("Add new \(category)")
                .font(.system(size: 10))
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 5)
        .frame(maxWidth: 100)
    }
}
//
#Preview {
    FoodCard(category: "Sweets")
}
//
//
//VStack {
//    Circle()
//        .overlay {
//            VStack {
//                Image(category)
//                    .resizable()
//                    .interpolation(/*@START_MENU_TOKEN@*/.high/*@END_MENU_TOKEN@*/)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
//                    .clipShape(Circle())
//                Image(systemName: "plus.circle")
//                    .foregroundStyle(.white)
//                
//            }
//        }
//        .foregroundStyle(.orange)
//    
//    Text("Add new \(category)")
//        .font(.system(size: 10))
//}
//.padding(.bottom, 5)
