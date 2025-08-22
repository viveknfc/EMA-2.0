//
//  SettingsVieModel.swift
//  IntelliStaff_EMA
//
//  Created by ios on 22/08/25.
//

import SwiftUI
import Combine
//
//@MainActor
//class SettingsViewModel: ObservableObject {
//     var deviceData: DeviceStatusResponse?
//     var isLoading = false
//     var errorMessage: String?
//
//    func fetchHistory(candidateID: Int, clientId: Int, lastName: String, ssn: String, weekend: Date) async {
//        isLoading = true
//        errorMessage = nil
//        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
//            print("User ID not found or not an Int")
//            return
//        }
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        
//        let params: [String: Any] = [
//            "CandidateId": "\(userId)",
//                "DeviceId": shortDeviceId(),
//                "OSType": "IOS",
//                "Status": 1
//        ]
//        
//        print("the params are:", params, terminator: "\n")
//        
//        do {
//            let result = try await APIFunction.primaryDeviceAPICalling(params: params)
//            self.deviceData = result
//            print("History API Result:", result)
//        } catch {
//            self.errorMessage = error.localizedDescription
//            print("History API Error:", error.localizedDescription)
//        }
//        
//        isLoading = false
//    }
//}


@MainActor
class SettingsViewModel: ObservableObject {
    @Published var shareLocation: Bool = false
    @Published var appNotifications: Bool = false
    @Published var primaryDevice: Bool = false
    @Published var status:Bool = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    var deviceData: DeviceStatusResponse?
    func updatePrimaryDevice(isOn: Bool) {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
                   print("User ID not found or not an Int")
                   return
               }
        let params: [String: Any] = [
                    "CandidateId": "\(userId)",
                        "DeviceId": shortDeviceId(),
                        "OSType": "IOS",
                        "Status": 1
                ]
        Task {
            do {
                deviceData = try await APIFunction.primaryDeviceAPICalling(params: params, token: "\(userId):")
                   
                alertMessage = deviceData?.message ?? ""
                if deviceData?.status == 1{
                    status = true
                }else{
                    status = false
                }
                showAlert = true
            } catch {
                alertMessage = "Something went wrong: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}
