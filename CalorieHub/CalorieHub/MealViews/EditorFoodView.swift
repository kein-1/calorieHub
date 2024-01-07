//
//  EditFoodView.swift
//  CalorieHub
//
//  Created by Kein Li on 1/1/24.
//

import SwiftUI
import SwiftData

struct EditorFoodView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var food : Food
    
    var body: some View {
            Form {
                Section("Edit Name") {
                    TextField("Edit Name: ", text: $food.name)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section("Edit Calories"){
                    TextField("Edit Calories:", text: $food.calories)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section("Edit Fat"){
                    TextField("Edit Fat", text: $food.fats.bound)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section("Edit Protein") {
                    TextField("Edit Protein", text: $food.protein.bound)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section("Edit Carbs"){
                    TextField("Edit Carbs", text: $food.carbohydrate.bound)
                        .textFieldStyle(.roundedBorder)
                }
                
                Picker("Meal Type", selection: $food.mealTime) {
                    ForEach(Food.mealTimes, id: \.self) { mealTime in
                        Text(mealTime)
                    }
                }
                .pickerStyle(.menu)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit Food Info")
            .toolbarRole(.editor)
    }
}
//
//#Preview {
//    return EditorFoodView(food: Food("Granola Bar", "Snack", "150", "8", "2", "20", "Snack"))
//        .modelContainer(DataPreviewController.mainContainer)
//}
