//
//  PreviewContainer.swift
//  CalorieHub
//
//  Created by Kein Li on 12/31/23.
//

import Foundation
import SwiftData

// Mark: Goal of this is to populate swiftdata with testing data (extension option did not work)
// This one is used to see data in Preview in Xcode. Great for testing

@MainActor
class DataPreviewController {
    
    static let mainContainer : ModelContainer = {
        do {
            // This sets configuration allowing data to NOT be saved across instances of app launches. Useful for testing/preview
            // Basically saying for each of the data types, this will be its configuration. We do this for more explicit control
            let config = ModelConfiguration(for: Food.self, UserGoals.self, isStoredInMemoryOnly: true)
            
            // VERY IMPORTANT Note : Make only ONE model config.. i was making separate ones and it crashed my code for the container
            // Seems to work fine in simulator though
            let container = try ModelContainer(for: Food.self, UserGoals.self, configurations: config)
            
            
            let sampleData : [Food] = [
                Food("Chicken Salad", "Salad", "150", "25", "15", "20", "Lunch"),
                Food("Caesar Salad", "Salad", "220", "20", "10","20", "Dinner"),
                
                Food("Spaghetti Bolognese", "Pasta", "150", "20", "30", "40", "Dinner"),
                
                Food("Green Smoothie", "Smoothie", "200", "3", "25","20", "Breakfast"),
                
                Food("Mixed Nuts", "Snack", "150", "15", "5", "10","Misc."),
                
                Food("Vegetable Stir-Fry", "Misc.", "250", "7", "30", "20","Dinner"),
                
                Food("Hot Pot", "Misc.", "200", "10", "5", "20","Lunch")
            ]
            
            for data in sampleData {
                container.mainContext.insert(data)
            }
            
            let sampleData2 = UserGoals(2000.5, 10000)
            sampleData2.updateAll(2000, 60, 150, 220)
            
            container.mainContext.insert(sampleData2)
            
            return container
        } catch {
            print("failed to create")
            fatalError("Failed to create container")
        }
    }() // runs the closure and assigns its value to previewContainer
}

