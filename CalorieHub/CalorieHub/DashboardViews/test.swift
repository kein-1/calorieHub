//
//  test.swift
//  CalorieHub
//
//  Created by Kein Li on 1/5/24.
//

import SwiftUI

struct test: View {
    var body: some View {
        HStack(spacing: 30) {
            Circle()
            RoundedRectangle(cornerRadius: 25)
                .stroke(.blue)
                
        }
        .padding()
        .border(.blue)
    }
}

#Preview {
    test()
}
