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
    
    @State private var viewModel = ETimeClockViewModel()
    @Binding var path: [AppRoute]
    
    let candidateID: Int?
    let ssn: String?
    let clientId: Int?
    let lastName: String?
    
   
    var body: some View {
        
        ZStack {
            if viewModel.showMainLayout {
                VStack(spacing: 30) {
                    Rounded_Rectangle_Button(title: "Clock In") {
                        Task { await viewModel.logTimeApiCall(mode: "login") }
                    }
                    .buttonStyle(ETimeClockButtonStyle(isDone: viewModel.isLoginDone))
                    .disabled(viewModel.isLoginDone)
                    
                    Rounded_Rectangle_Button(title: "Meal Out") {
                        Task { await viewModel.logTimeApiCall(mode: "lunchout") }
                    }
                    .buttonStyle(ETimeClockButtonStyle(isDone: !viewModel.isLunchOutDone))
                    .disabled(!viewModel.isLunchOutDone)
                    
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } else {
                Text(viewModel.noDataMessage)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                TriangleLoader()
            }
        }
        .onAppear {
            Task { await viewModel.getETCDetails(clientId: 0) }
        }
        
        // ✅ General alert
        if viewModel.showAlert {
            AlertView(
                title: "E-Time Clock",
                message: viewModel.alertMessage,
                primaryButton: AlertButtonConfig(title: "OK") {
                    viewModel.showAlert = false
                },
                dismiss: {
                    viewModel.showAlert = false
                }
            )
        }
        // ✅ Primary device alert
        if viewModel.showPrimaryAlert {
            AlertView(
                title: "Primary Device",
                message: viewModel.alertMessage,
                primaryButton: AlertButtonConfig(title: "OK") {
                    print("clicked ok from primary alert")
                    viewModel.showPrimaryAlert = false
                    path.append(.settings)  // 👈 navigate to settings
                },
                dismiss: {
                    viewModel.showPrimaryAlert = false
                }
            )
        }
    }
}

struct ETimeClock_Previews: PreviewProvider {
    @State static var path: [AppRoute] = []   // Mock navigation path

    static var previews: some View {
        e_TimeClock(
            path: $path, candidateID: 12345,
            ssn: "987-65-4321",
            clientId: 6789,
            lastName: "Doe"
        )
    }
}

