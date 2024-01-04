//
//  PersonalView.swift
//  CalorieHub
//
//  Created by Kein Li on 1/1/24.
//

import SwiftUI
import SwiftData


struct PersonalView: View {
    
    @Environment(\.modelContext) private var context
//    @Query var goals : [UserGoals]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                //            Text("\(goals.count)")
                Text("hi")
                //            Text("\(goals[0].stepsGoal ?? 123)")
                //            Text("\(goals[0].weightGoal ?? 123)")
            }
           
        }
    }
}
//
//#Preview {
//    return PersonalView()
//        .modelContainer(DataPreviewController.userGoalPreviewContainer)
//}
