//
//  FoodModel.swift
//  CalorieHub
//
//  Created by Kein Li on 12/19/23.
//

import Foundation
import SwiftData

// Food model : user tracks each food

@Model
class Food {
    
    var name : String
    var date : String
    var category : String
    var calories : String
    var fats : String?
    var protein : String?
    var carbohydrate : String?
    var mealTime : String
    
    
    init(_ name: String, _ category: String, _ calories: String, _ fats: String?, _ protein: String?, _ carbohydrate: String?, _ mealTime: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.date = dateFormatter.string(from: Date())
        
        self.name = name
        self.category = category
        self.calories = calories
        self.fats = fats
        self.protein = protein
        self.carbohydrate = carbohydrate
        self.mealTime = mealTime
    }
    
    static let mealTimes = [
        "Breakfast",
        "Lunch",
        "Dinner",
        "Snack",
        "Other"
    ]
    
    
    static let sectionTitles = [
        "Food Name",
        "Calories",
        "Fats",
        "Carbohydrates",
        "Proteins"
    ]

    static let textFieldPlaceholders = [
        "(Required) Enter Food name",
        "(Required) Enter Calories",
        "(Optional) Enter Fats",
        "(Optional) Enter Carbs",
        "(Optional) Enter Proteins"
    ]
    
    static let foodCategories = ["Breakfast", "Lunch", "Dinner", "Sweets", "Drinks", "Other"]

}
//
//

// Mark : Workaround to using predicates and dates. Predicates do not work with dates right now
extension Food {

    static func currentPredicate() -> Predicate<Food> {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateStringOne = dateFormatter.string(from: Date())
            
        return #Predicate<Food> { food in
            food.date == dateStringOne
        }
    }
}
