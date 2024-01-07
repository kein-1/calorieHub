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
        VStack(alignment: .leading) {
            Text("Calorie Progress")
                .font(.subheadline)
            HStack {
                VStack {
                    
                    Text(viewModel.totalCalories.formatted())
                        .font(.system(size: 24))
                    HStack {
                        Text("Eaten")
                            .font(.caption)
                        Image(systemName: "heart.fill")
                        
                    }
                }
                
                Spacer()
                
                CircularProgressView(progress: viewModel.progressCalories, remainingCalories: viewModel.remainingCalories)
                
                Spacer()
                
                VStack {
                    if let caloriesBurned = healthStore.caloriesBurnedToday {
                        Text(caloriesBurned.formatted())
                            .font(.system(size: 24))
                        HStack {
                            Text("Burned")
                                .font(.caption)
                            Image(systemName: "flame")
                        }
                        
                    } else {
                        Text("0")
                            .font(.system(size: 24))
                        HStack {
                            Text("Burned")
                                .font(.caption)
                            Image(systemName: "flame")
                        }
                    }
                }
            }
            .foregroundStyle(.orange)
            .padding()
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .onAppear {
                viewModel.updateNutrition(foods, userGoals)
                healthStore.readTodaysActivity()
            }
        }
        .padding()
    }
}



//
//
//#Preview {
//    let vm = ViewModel()
//    let healthStore = HealthStore()
//    healthStore.caloriesBurnedToday = 300
//    healthStore.stepsTakenToday = 1500.0
//    return CaloriesEatenAndBurnedView()
//        .modelContainer(DataPreviewController.mainContainer)
//        .environment(vm)
//        .environment(healthStore)
//}
//
