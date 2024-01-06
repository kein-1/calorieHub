//
//  ContentView.swift
//  CalorieHub
//
//  Created by Kein Li on 12/19/23.
//

import SwiftUI
import HealthKit


struct ContentView: View {
    
    
    var body: some View {
        VStack {
            Text("caloriehub")
                .font(.title)
                .foregroundStyle(.orange)
                .padding(.bottom, 15)
            
            TabView {
                DashBoardView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                MealsView()
                    .tabItem {
                        Label("Meals", systemImage: "fork.knife")
                    }
                
                PersonalView()
                    .tabItem {
                        Label("Personal", systemImage: "person")
                    }
            }
        }
    }
}
//
#Preview {
    
    let healthStore = HealthStore()
    let viewModel = ViewModel()
    
    return ContentView()
        .environment(healthStore)
        .environment(viewModel)
        .modelContainer(DataPreviewController.mainContainer)
}
