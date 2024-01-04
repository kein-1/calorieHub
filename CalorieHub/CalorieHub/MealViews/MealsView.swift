//
//  PrimaryView.swift
//  CalorieHub
//
//  Created by Kein Li on 12/28/23.
//

import SwiftUI
import SwiftData

struct MealsView: View {
    @Environment(HealthStore.self) private var healthStore
    @Environment(ViewModel.self) private var viewModel
    @Environment(\.modelContext) private var context
    
//    var currDate = viewModel.selectedDate
    
    @Query(filter: Food.currentPredicate()) var foods : [Food]
    
    var body: some View {
        NavigationStack {
            FoodCategoryRowView()
            List(Food.mealTimes, id: \.self) { mealTime in
                Section {
                    ForEach(foods) { food in
                        if food.mealTime == mealTime {
                            NavigationLink(value: food){
                                FoodDisplayItem(food: food)
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                } header: {
                    HStack {
                        Text(mealTime)
                        Spacer()
                        Text("Calories")
                    }
                    .foregroundStyle(.orange)
                }
                .listSectionSeparator(.hidden)
            }
            .listStyle(.grouped)
            .navigationTitle("Today's Food")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Food.self) { food in
                EditorFoodView(food: food)
            }
            .toolbar {
                EditButton()
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    // Mark : Deletes an item in the data set
    func deleteFood(indexSet : IndexSet) {
        for index in indexSet {
            context.delete(foods[index])
        }
    }
    
}
//
//#Preview {
//    var healthStore = HealthStore()
//    var viewModel = ViewModel()
//    return MealsView()
//        .environment(healthStore)
//        .environment(viewModel)
//        .modelContainer(DataPreviewController.foodPreviewContainer)
//}
