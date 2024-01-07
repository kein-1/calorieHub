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
        NavigationStack{
            VStack {
                CaloriesEatenAndBurnedView()
                Nutritient_Card()
                StepsProgressView()
                Spacer()
            }
            .background(
                LinearGradient(colors: [Color.white.opacity(0.7), Color.orange.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing), ignoresSafeAreaEdges: [.top,.leading,.trailing])
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Image(systemName: "bell").badge(4)
                    Image(systemName: "person").badge(2)
                  }
                
                ToolbarItem(placement: .principal) {
                    Text("calorieHub")
                        .font(.system(size: 24))
                        .foregroundStyle(.orange)
                }
            }
            .navigationTitle("Today")
            
        }
    }
}
    
//
//#Preview {
//    DashBoardView()
//        .modelContainer(DataPreviewController.mainContainer)
//}
