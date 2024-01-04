//
//  AddFoodFormSub.swift
//  CalorieHub
//
//  Created by Kein Li on 12/30/23.
//

import SwiftUI




struct AddFoodFormSubView: View {
    
    var sectionTitle : String
    var placeHolder : String
    @Binding var field : String?
    
    var body: some View {
        Section(sectionTitle) {
            TextField(placeHolder, text: $field.bound)
                .overlay(alignment: .bottom) { // great trick to add a bottom bar
                    Divider()
                }
        }
    }
}
//
//#Preview {
//    AddFoodFormSub()
//}
