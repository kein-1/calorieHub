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
                Text("Calories")
                Text("1234")
            }
            Spacer()
           
            CircularProgressView(progress: viewModel.progress, remainingCalories: viewModel.remainingCalories)
            
            Spacer()
            
            VStack {
                Text("Steps")
                Text("1234")
                Text("\(viewModel.remainingCalories ?? 0)")
                Text("\(viewModel.totalCalories)")
                Text("\(viewModel.currentUserGoals?.dailyCaloriesGoal ?? 0)")
            }
        }
        .padding()
        .background()
        .border(.blue)
        .onAppear {
            viewModel.updateNutrition(foods, userGoals)
        }
    }
}




//
//#Preview {
//    let vm = ViewModel()
//    let healthStore = HealthStore()
//    return CaloriesEatenAndBurnedView()
//        .modelContainer(DataPreviewController.mainContainer)
//        .environment(vm)
//        .environment(healthStore)
//}

