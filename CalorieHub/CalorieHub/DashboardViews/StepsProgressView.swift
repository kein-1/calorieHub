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
        RoundedRectangle(cornerRadius: 30.0)
            .fill(.clear)
            .strokeBorder(.blue, lineWidth: 3)
            .overlay {
                VStack {
                    ProgressView(value: healthStore.stepsTakenToday, total: viewModel.progressSteps())
                    
                    Text((healthStore.stepsTakenToday ?? 0).formatted())
                    Text(viewModel.progressSteps().formatted())
                }
            }
    }
    
    
}
//
//#Preview {
//    StepsProgressView()
//}
