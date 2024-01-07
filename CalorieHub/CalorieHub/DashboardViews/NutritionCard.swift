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
        VStack(alignment: .leading) {
            Text("Macro Progress")
                .font(.subheadline)
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
            .padding()
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
            
            .onAppear {
                viewModel.updateNutrition(foods, userGoals)
            }
        }
        .padding()
        
    }
}
//
//#Preview {
//    let vm = ViewModel()
//    return Nutritient_Card()
//        .modelContainer(DataPreviewController.mainContainer)
//        .environment(vm)
//}
