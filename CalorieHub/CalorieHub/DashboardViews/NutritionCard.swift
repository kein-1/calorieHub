//
//  Nutritient Card.swift
//  CalorieHub
//
//  Created by Kein Li on 1/2/24.
//

import SwiftUI
import SwiftData

struct Nutritient_Card: View {
    
    @Environment(ViewModel.self) var viewModel
    @Query(filter: Food.currentPredicate()) var foods : [Food]
    @Query var userGoals : [UserGoals]
    @State private var appeared = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 30.0)
                .fill(.clear)
                .strokeBorder(.orange, lineWidth: 3)
                .shadow(radius: 3)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .padding()
                .overlay {
                    HStack(spacing: 30) {
                        
                        MacroProgressCardView(title: "Fat",
                                              value: viewModel.totalFats,
                                              total: userGoals[0].dailyFatsGoal ?? 0,
                                              color: Color.orange,
                                              valueInGrams: viewModel.totalFats, 
                                              totalInGrams: userGoals[0].dailyFatsGoal ?? 0)
                        
                        MacroProgressCardView(title: "Protein",
                                              value: viewModel.totalProteins,
                                              total: userGoals[0].dailyProteinGoal ?? 0,
                                              color: Color.indigo,
                                              valueInGrams: viewModel.totalProteins,
                                              totalInGrams: userGoals[0].dailyProteinGoal ?? 0)
                        
                        MacroProgressCardView(title: "Carbs",
                                              value: viewModel.totalCarbs,
                                              total: userGoals[0].dailyCarbsGoal ?? 0,
                                              color: Color.mint,
                                              valueInGrams: viewModel.totalCarbs,
                                              totalInGrams: userGoals[0].dailyCarbsGoal ?? 0)
                    }
                    .padding(30)
                }
        }
        .onAppear {
            viewModel.updateNutrition(foods, userGoals)
        }
    }
}

#Preview {
    let vm = ViewModel()
    return Nutritient_Card()
        .modelContainer(DataPreviewController.mainContainer)
        .environment(vm)
}
