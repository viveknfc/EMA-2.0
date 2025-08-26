//
//  Toggle_View.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 25/08/25.
//

import SwiftUI

struct SimpleToggleCard: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack (spacing: 2){
            HStack {
                Text(title)
                    .font(.buttonFont)
                
                Spacer()
                
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: .theme)) // native but clean
            }
            .padding()
            
            DottedLine()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 8]))
                .foregroundColor(.gray)
                .frame(height: 1)
                .padding(.horizontal, 12)
                .padding(.bottom, 4)
        }
    }
}

#Preview {
    VStack {
        SimpleToggleCard(title: "Enable Notifications", isOn: .constant(true))
        SimpleToggleCard(title: "Dark Mode", isOn: .constant(false))
        SimpleToggleCard(title: "Location Access", isOn: .constant(true))
    }
    .padding()
}

