//
//  ViewModel.swift
//  CalorieHub
//
//  Created by Kein Li on 12/30/23.
//

import SwiftUI
import Observation

// Mark : ViewModel to store nutrition data and perform some calculations

@Observable
class ViewModel {
    
    var selectedDate = Date()
    var totalCalories = 0
    var totalFats = 0
    var totalProteins = 0
    var totalCarbs = 0


    func updateNutrition(_ foods : [Food]){
        totalCalories = foods.reduce(0, {$0 + (Int($1.calories) ?? 0)})
        totalFats = foods.reduce(0, {$0 + (Int($1.fats ?? "") ?? 0)})
        totalProteins = foods.reduce(0, {$0 + (Int($1.protein ?? "") ?? 0)})
        totalCarbs = foods.reduce(0, {$0 + (Int($1.carbohydrate ?? "") ?? 0)})
    }
}


