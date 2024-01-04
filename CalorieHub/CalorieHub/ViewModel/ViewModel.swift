//
//  ViewModel.swift
//  CalorieHub
//
//  Created by Kein Li on 12/30/23.
//

import SwiftUI
import Observation

// Mark : ViewModel to store nutrition data and perform some calculations
// Not sure if this is the best app architecture but the general
// approach is to @Query from the view, then inject this data to ViewModel
// where calculations are performed
@Observable
class ViewModel {
    
    var selectedDate = Date()
    var totalCalories = 0
    var totalFats = 0
    var totalProteins = 0
    var totalCarbs = 0
    var currentUserGoals: UserGoals? // Stores a reference to the userGoals (likely unecessary since we need to save it with swiftdata though, so no modifications here)
    
   
    var remainingCalories: Int? {
        if let dailyCaloriesGoal = currentUserGoals?.dailyCaloriesGoal {
            return dailyCaloriesGoal - totalCalories
        }
        return nil
    }
    
    var progress : Double {
        if let dailyCaloriesGoal = currentUserGoals?.dailyCaloriesGoal {
            return Double(totalCalories)/Double(dailyCaloriesGoal)
        }
        return 0.0
    }
    

    func updateNutrition(_ foods : [Food], _ userGoals : [UserGoals]){
        
        if foods.isEmpty { return }
        
        totalCalories = foods.reduce(0, {$0 + (Int($1.calories) ?? 0)})
        totalFats = foods.reduce(0, {$0 + (Int($1.fats ?? "") ?? 0)})
        totalProteins = foods.reduce(0, {$0 + (Int($1.protein ?? "") ?? 0)})
        totalCarbs = foods.reduce(0, {$0 + (Int($1.carbohydrate ?? "") ?? 0)})
        
        if userGoals.isEmpty { return }
        
        currentUserGoals = userGoals[0]
    }
    
   
}


