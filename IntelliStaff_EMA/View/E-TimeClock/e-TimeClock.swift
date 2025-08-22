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

struct e_TimeClock: View {
    @StateObject private var viewModel = ETimeClockViewModel()
    let candidateID: Int?
    let ssn: String?
    let clientId: Int?
    let lastName: String?
   
    var body: some View {
        Group {
            if viewModel.navigateToSettings {
              
                SettingsScreen()   // 👉 directly show SettingsScreen
                
                
            } else {
                if viewModel.showMainLayout {
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
                        .padding(.top, 40)
                        .padding([.leading, .trailing], 50)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                } else {
                    Text(viewModel.alertMessage)
                }
            }
        }
        // 👇 attach alert to the Group
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("CMA 2.0"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK")) {
                    if viewModel.alertMessage.contains("Do you want to set this device as primary") {
                        viewModel.navigateToSettings = true
                    } else {
                        viewModel.navigateToSettings = false
                    }
                }
            )
        }
//        .onReceive(viewModel.$logTimeResponse.compactMap { $0 }) { response in
//            viewModel.retryCount = response.retry ?? 0
//                  if response.successStatus == 1 {
//                      viewModel.alertMessage = response.message ?? ""
//                      viewModel.showAlert = true
//                  } else {
//                      if response.retry == 1 {
//                          // Retry after Sleep seconds
//                          DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(response.sleep)) {
//                              viewModel.logTimeApiCall(mode: response.mode ?? "")
//                          }
//                      } else {
//                          viewModel.alertMessage = response.message ?? ""
//                          viewModel.showAlert = true
//                      }
//                  }
//              }
       
        .onAppear {
            Task {
                await viewModel.getETCDetails(clientId: 0)
            }
        }
    }
}
#Preview {
    e_TimeClock(candidateID: 12, ssn: "", clientId: 12, lastName: "")
}
