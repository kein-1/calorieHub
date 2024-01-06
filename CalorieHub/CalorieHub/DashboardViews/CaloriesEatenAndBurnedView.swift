//
//  CaloriesEatenAndBurnedView.swift
//  CalorieHub
//
//  Created by Kein Li on 1/4/24.
//

import SwiftUI
import SwiftData

struct CaloriesEatenAndBurnedView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(ViewModel.self) private var viewModel
    @Environment(HealthStore.self) private var healthStore
    
    @Query(filter: Food.currentPredicate()) var foods : [Food]
    @Query var userGoals : [UserGoals]
    
    var body: some View {
        HStack {
            
            VStack {
                Text("Eaten")
                Text(viewModel.totalCalories.formatted())
            }
            Spacer()
           
            CircularProgressView(progress: viewModel.progressCalories, remainingCalories: viewModel.remainingCalories)
            
            Spacer()
            
            VStack {
                
                if let caloriesBurned = healthStore.caloriesBurnedToday {
                    Text(caloriesBurned.formatted())
                    Text("Burned")
                } else {
                    Text("0")
                    Text("Burned")
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.updateNutrition(foods, userGoals)
            healthStore.readTodaysActivity()
        }
    }
}





#Preview {
    let vm = ViewModel()
    let healthStore = HealthStore()
    return CaloriesEatenAndBurnedView()
        .modelContainer(DataPreviewController.mainContainer)
        .environment(vm)
        .environment(healthStore)
}

