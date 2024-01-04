//
//  DashBoardView.swift
//  CalorieHub
//
//  Created by Kein Li on 1/1/24.
//

import SwiftUI
import SwiftData


// Mark : Primary landing view for user
// Designed to read user's steps, calories,
// total goals etc for the day
struct DashBoardView: View {
    

    var body: some View {
        VStack {
            CaloriesEatenAndBurnedView()
            Nutritient_Card()
        }
    }
}
    
//
//#Preview {
//    DashBoardView()
//        .modelContainer(DataPreviewController.foodPreviewContainer)
//}
