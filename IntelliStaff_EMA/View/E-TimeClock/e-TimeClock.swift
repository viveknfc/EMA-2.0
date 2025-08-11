//
//  e-TimeClock.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 31/07/25.
//

import SwiftUI

struct e_TimeClock: View {
    
    var Button1: String = "Clock In"
    var Button2: String = "Lunch Out"
    var Button3: String = "Lunch Return"
    var Button4: String = "Clock Out"
    
    let candidateID: Int?
    let ssn: String?
    let clientId: Int?
    let lastName: String?
    
    var body: some View {
        VStack (spacing: 30) {
            Rounded_Rectangle_Button(title: Button1) {
                print("clock in clicked")
            }
            Rounded_Rectangle_Button(title: Button2) {
                print("Lunch out clicked")
            }
            Rounded_Rectangle_Button(title: Button3) {
                print("Lunch return clicked")
            }
            Rounded_Rectangle_Button(title: Button4) {
                print("clock out clicked")
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .padding([.leading, .trailing], 50)
        
    }
}

#Preview {
    e_TimeClock(candidateID: 12, ssn: "", clientId: 12, lastName: "")
}
