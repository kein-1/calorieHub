//
//  AddFoodForm.swift
//  CalorieHub
//
//  Created by Kein Li on 12/29/23.
//

import SwiftUI

struct AddFoodForm: View {
    
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss 
   
    @State private var mealTime = "Breakfast"
    
    //Mark:  name, calories, fats, carbs, protein
    // keep this in-line with title and placeholder. 1:1 match
    @State private var arr : [String?] = Array(repeating: "", count: 5)
    
    var title = Food.sectionTitles
    var placeHolder = Food.textFieldPlaceholders
    
    var category : String
    
    var body: some View {
        Form {
            ForEach($arr.indices, id: \.self) { index in
                AddFoodFormSubView(sectionTitle: title[index], placeHolder: placeHolder[index], field: $arr[index])
            }
            
            Section("Meal Time "){
                Picker("", selection: $mealTime) {
                    ForEach(Food.mealTimes, id: \.self) { meal in
                        Text(meal).tag(meal)
                    }
                }
                .pickerStyle(.palette)
            }
        }
        .navigationTitle("Add a food ") // without this, the backbutton has the text of the previous view's nav title
        .scrollContentBackground(.hidden) // hides the form's background
        
        Button {
            addFood()
            dismiss()
        } label: {
            AddFoodButton()
        }
    }
    
    
    func addFood() {
        let name = arr[0] ?? ""
        let calories = arr[1] ?? ""
        let food = Food(name , category, calories, arr[2], arr[3], arr[4], mealTime)
        context.insert(food)
    }
}

//#Preview {
//    var healthStore = HealthStore()
//    var viewModel = ViewModel()
//   
//    return AddFoodForm(category: "Sweets")
//        .environment(healthStore)
//        .environment(viewModel)
//}
