//
//  PersonalInfoView.swift
//  CalorieHub
//
//  Created by Kein Li on 12/19/23.
//

import SwiftUI
import SwiftData

struct PersonalInfoView: View {
    
    // Mark : - Properties
    @Environment(HealthStore.self) private var healthStore
    @Environment(\.modelContext) private var context
    
    @Binding var selection : Int
    @State private var userAge : Int?
    @State private var userWeight : Double?
    @State private var userHeight : Double?
    
    @State private var userWeightGoal : Double?
    @State private var userStepsGoal : Double?
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Mark : - User info form
            
            HStack {
                Text("Tell us about")
                Text("yourself!")
                    .foregroundStyle(.orange)
            }
            .font(.headline)
            
            List {
                Section {
                    TextField("Enter your age", value: $userAge, format: .number)
                        .textFieldStyle(.roundedBorder)
                    
                } header: {
                    Text("Age")
                }
                
                Section {
                    TextField("Enter weight (lbs)", value: $userWeight, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Weight (lbs)")
                }
                
                Section {
                    TextField("Enter height (in)", value: $userHeight, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("Height (in)")
                }
                
                Section {
                    TextField("Enter goal weight (lbs)", value: $userWeightGoal, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("What is your goal weight?")
                }
                
                Section {
                    TextField("Enter steps goal", value: $userStepsGoal, format: .number)
                        .textFieldStyle(.roundedBorder)
                } header: {
                    Text("What is your daily steps goal?")
                }
                
                
            }
            .ignoresSafeArea(.keyboard, edges: .bottom) // added to stop keyboard from pushing up view
            .scrollContentBackground(.hidden)
            
            // Mark : - Save user data + Next screen
            Button{
                healthStore.savingUserData(userWeight, userHeight)
                let info = UserGoals(userWeightGoal, userStepsGoal)
                context.insert(info)
                withAnimation {
                    selection += 1
                }
            } label: {
                CustomLabel(text: "Next")
            }
        }
    }
}
//
#Preview {
    let healthStore = HealthStore()
    return PersonalInfoView(selection: .constant(0))
        .environment(healthStore)
        .modelContainer(for: [Food.self, UserGoals.self])
}
