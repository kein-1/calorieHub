//
//  FoodCategoryRowView.swift
//  CalorieHub
//
//  Created by Kein Li on 12/31/23.
//

import SwiftUI

struct FoodCategoryRowView: View {
    
    let foodCategories = Food.foodCategories
    @State private var showFoodForm = false
    
    var body: some View {
        Grid {
            GridRow {
                ForEach(foodCategories, id:\.self) { category in
                    Button {
                        showFoodForm.toggle()
                    } label: {
                        FoodCard(category:category)
                    }
                    .sheet(isPresented: $showFoodForm) {
                        AddFoodForm(category: category)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
    }
}

#Preview {
    FoodCategoryRowView()
}
