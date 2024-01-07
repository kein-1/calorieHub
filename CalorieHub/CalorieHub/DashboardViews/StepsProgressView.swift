//
//  StepsProgressView.swift
//  CalorieHub
//
//  Created by Kein Li on 1/5/24.
//

import SwiftUI
import SwiftData
struct StepsProgressView: View {
    
    @Environment(ViewModel.self) private var viewModel
    @Environment(HealthStore.self) private var healthStore
    
    var body: some View {
        VStack(alignment : .leading) {
            Text("Steps Progress")
                .font(.subheadline)
            HStack {
                Image(systemName: "shoeprints.fill")
                ProgressView(value: healthStore.stepsTakenToday, total: viewModel.progressSteps()) {
                    Text((healthStore.stepsTakenToday?.formatted() ?? "") + " / " + viewModel.progressSteps().formatted())
                        .font(.system(size: 14))
                }
            }
            .padding(20)
            .background(.ultraThickMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            // Testing purposes since the container needs to be initialized before this can be made
            // I could have initialized a container in preview or a separete one in DataPreviewController
            // but I think it is tricky with the viewModel storing an instance as well so this might be better
//            .onAppear {
//                viewModel.currentUserGoals = UserGoals(15000,15000)
//            }
        }
        .padding()
    }
    
}
//
//#Preview {
//    
//    // setup some sample data
//    let vm = ViewModel()
//    let healthStore = HealthStore()
//    healthStore.caloriesBurnedToday = 300
//    healthStore.stepsTakenToday = 1500.0
//        
//    return StepsProgressView()
//        .modelContainer(DataPreviewController.mainContainer)
//        .environment(vm)
//        .environment(healthStore)
//}
