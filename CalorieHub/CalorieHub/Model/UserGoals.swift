//
//  UserGoals.swift
//  CalorieHub
//
//  Created by Kein Li on 1/2/24.
//

import Foundation
import SwiftData

@Model
class UserGoals {
    
    var weightGoal : Double?
    var stepsGoal : Double?
    var dailyCaloriesGoal: Int?
    var dailyFatsGoal: Int?
    var dailyProteinGoal: Int?
    var dailyCarbsGoal: Int?
    
    init(_ weightGoal: Double? = nil, _ stepsGoal: Double? = nil) {
        self.weightGoal = weightGoal
        self.stepsGoal = stepsGoal
    }
    
    func updateAll(_ calories : Int?, _ fats: Int?, _ protein: Int?, _ carbs: Int?){
        dailyCaloriesGoal = calories
        dailyFatsGoal = fats
        dailyProteinGoal = protein
        dailyCarbsGoal = carbs
    }
}


