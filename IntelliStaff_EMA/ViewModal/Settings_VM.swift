//
//  SettingsVieModel.swift
//  IntelliStaff_EMA
//
//  Created by ios on 22/08/25.

import SwiftUI

@MainActor
@Observable
class SettingsViewModel {
    var shareLocation: Bool = false
    var appNotifications: Bool = false
    var primaryDevice: Bool = false {
        didSet {
            updatePrimaryDevice(isOn: primaryDevice)
        }
    }
    
    var status: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var deviceData: DeviceStatusResponse?
    var isLoading = false

    func updatePrimaryDevice(isOn: Bool) {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("User ID not found or not an Int")
            return
        }
        isLoading = true
        let params: [String: Any] = [
            "CandidateId": "\(userId)",
            "DeviceId": shortDeviceId(),
            "OSType": "IOS",
            "Status": isOn ? 1 : 0
        ]
        
        print("primary device param \(params)")
        
        Task {
            do {
                deviceData = try await APIFunction.primaryDeviceAPICalling(params: params, token: "\(userId):")
                status = deviceData?.status == 1
                alertMessage = deviceData?.message ?? "Updated successfully"
            } catch {
                alertMessage = "Something went wrong: \(error.localizedDescription)"
                status = false
            }
            showAlert = true
            isLoading = false
        }
    }
}
