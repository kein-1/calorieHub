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
    
    // Sample test data : Edit - this seems to crash swiftdata. extension does not work 
//    static var sampleData : [Food] = [
//            Food("Chicken Salad", "Salad", "350", "25", "15", "20", "Lunch"),
//            Food("Caesar Salad", "Salad", "300", "20", "10","20", "Dinner"),
//            
//            Food("Spaghetti Bolognese", "Pasta", "450", "20", "30", "40", "Dinner"),
//            Food("Penne Arrabiata", "Pasta", "400", "15", "25", "35", "Snack"),
//            
//            Food("Fruit Smoothie", "Smoothie", "200", "5", "30", "20","Breakfast"),
//            Food("Green Smoothie", "Smoothie", "180", "3", "25","20", "Breakfast"),
//            
//            Food("Granola Bar", "Snack", "150", "8", "2", "20", "Snack"),
//            Food("Mixed Nuts", "Snack", "200", "15", "5", "10","Misc."),
//            
//            Food("Grilled Chicken", "Misc.", "300", "30", "5", "20","Lunch"),
//            Food("Vegetable Stir-Fry", "Misc.", "250", "15", "30", "20","Dinner"),
//    ]

}
