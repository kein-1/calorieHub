//
//  FoodDisplayItem.swift
//  CalorieHub
//
//  Created by Kein Li on 12/30/23.
//

import SwiftUI
import SwiftData


struct FoodDisplayItem: View {
    
    var food : Food
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(food.name)
                HStack {
                    Text("Fats : \(food.fats ?? "-") g |")
                    Text("Protein : \(food.protein ?? "-") g |")
                    Text("Carbs : \(food.carbohydrate ?? "-") g")
                }
                .font(.caption2)
                .foregroundStyle(.gray)
            }
            Spacer()
            Text(food.calories)
        }
    }
}
//
//#Preview {
//    FoodDisplayItem()
//}
