//
//  PersonalInfoView2.swift
//  CalorieHub
//
//  Created by Kein Li on 1/2/24.
//

import SwiftUI
import SwiftData


struct PersonalInfoMacrosView: View {
    
    // Mark : - Properties
    @Environment(HealthStore.self) private var healthStore
    @Environment(\.modelContext) private var context
    @Query private var userGoals : [UserGoals]
    
    @Binding var selection : Int
    @State private var userCalories : Int?
    @State private var userFats : Int?
    @State private var userProteins : Int?
    @State private var userCarbs: Int?
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Mark : - User info form
            VStack {
                Text("Almost there ! ")
                Text("What are your daily nurition requirements?")
                    .foregroundStyle(.orange)
            }
            .font(.headline)
            .multilineTextAlignment(.center)
            
            List {
                Section {
                    TextField("Enter your daily calories goal", value: $userCalories, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Calories Goal")
                }
                
                Section {
                    TextField("Enter your daily fats goal", value: $userFats, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Fats (g) ")
                }
                
                Section {
                    TextField("Enter your daily proteins goal", value: $userProteins, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Proteins (g) ")
                }
                
                Section {
                    TextField("Enter your daily proteins goal", value: $userCarbs, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Carbs (g) ")
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom) // added to stop keyboard from pushing up view
            .scrollContentBackground(.hidden)
            
            // Mark : - Save user data + Next screen
            Button{
                saveInfo()
                withAnimation {
                    selection += 1
                }
            } label: {
                CustomLabel(text: "Next")
            }
        }
    }
    
    func saveInfo(){
        var userGoal = userGoals[0]
        userGoal.updateAll(userCalories, userFats, userProteins, userCarbs)
    }
}
//
#Preview {
    let healthStore = HealthStore()
    return PersonalInfoMacrosView(selection: .constant(0))
        .environment(healthStore)
        .modelContainer(for: [Food.self, UserGoals.self])
}
