//
//  e-TimeClock.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 31/07/25.
//

import SwiftUI

struct ETimeClockButtonStyle: ButtonStyle {
    var isDone: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(isDone ? Color.gray : Color.white)
            .foregroundColor(isDone ? Color.white : Color.accentColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isDone ? Color.gray : Color.accentColor, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}


//import SwiftUI
//
//struct e_TimeClock: View {
//    
//    var Button1: String = "Clock In"
//    var Button2: String = "Lunch Out"
//    var Button3: String = "Lunch Return"
//    var Button4: String = "Clock Out"
//    
//    let candidateID: Int?
//    let ssn: String?
//    let clientId: Int?
//    let lastName: String?
//    
//    var body: some View {
//        VStack (spacing: 30) {
//            Rounded_Rectangle_Button(title: Button1) {
//                print("clock in clicked")
//            }
//            Rounded_Rectangle_Button(title: Button2) {
//                print("Lunch out clicked")
//            }
//            Rounded_Rectangle_Button(title: Button3) {
//                print("Lunch return clicked")
//            }
//            Rounded_Rectangle_Button(title: Button4) {
//                print("clock out clicked")
//            }
//            
//            Spacer()
//        }
//        .padding(.top, 40)
//        .padding([.leading, .trailing], 50)
//        
//    }
//}
//
//#Preview {
//    e_TimeClock(candidateID: 12, ssn: "", clientId: 12, lastName: "")
//}
struct e_TimeClock: View {
    @StateObject private var viewModel = ETimeClockViewModel()
    let candidateID: Int?
    let ssn: String?
    let clientId: Int?
    let lastName: String?
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Rounded_Rectangle_Button(title: "Clock In") {
                    Task { await viewModel.logTimeApiCall(mode: "login") }
                }
                .buttonStyle(ETimeClockButtonStyle(isDone: viewModel.isLoginDone))
                .disabled(viewModel.isLoginDone)
                
                Rounded_Rectangle_Button(title: "Meal Out") {
                    Task { await viewModel.logTimeApiCall(mode: "lunchout") }
                }
                .buttonStyle(ETimeClockButtonStyle(isDone: viewModel.isLunchOutDone))
                .disabled(viewModel.isLunchOutDone)
                
                Rounded_Rectangle_Button(title: "Meal Return") {
                    Task { await viewModel.logTimeApiCall(mode: "lunchin") }
                }
                .buttonStyle(ETimeClockButtonStyle(isDone: viewModel.isLunchInDone))
                .disabled(viewModel.isLunchInDone)
                
                Rounded_Rectangle_Button(title: "Clock Out") {
                    Task { await viewModel.logTimeApiCall(mode: "logout") }
                }
                .buttonStyle(ETimeClockButtonStyle(isDone: viewModel.isLogOutDone))
                .disabled(viewModel.isLogOutDone)
            }
            .padding(.top, 20)
            .padding([.leading, .trailing], 50)
            
            Spacer() // 👈 pushes everything to the top
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // extra safety
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("CMA 2.0"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    // 👉 Navigate to Settings tab
                }
            )
        }
        .onAppear {
            Task {
                await viewModel.getETCDetails(clientId: 0)
            }
        }
    }
}
