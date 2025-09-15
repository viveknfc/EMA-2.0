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
    var isUpdatingLocation = false
    var appNotifications: Bool = false
    var isUpdateNotification = false
    var primaryDevice: Bool = false
    var isUpdatingprimaryDevice = false
    
    var showAlert: Bool = false
    var alertMessage: String = ""
    var isLoading = false
    
    var isInitialLoad = true
    
    //MARK: - Update Primary Device API

    func updatePrimaryDevice(isOn: Bool) {

        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("User ID not found or not an Int")
            return
        }
        isLoading = true
        print("the is on value is \(isOn)")

        let params: [String: Any] = [
            "CandidateId": "\(userId)",
            "DeviceId": shortDeviceId(),
            "OSType": "IOS",
            "Status": isOn ? 1 : 0
        ]
        
        print("primary device param \(params)")
        
        Task {
            do {
                let deviceData = try await APIFunction.primaryDeviceAPICalling(params: params)
                print("the device data is \(deviceData)")
                isUpdatingprimaryDevice = true
                let apiStatus = deviceData.messageStatus == 1
                primaryDevice = apiStatus
                UserDefaults.standard.set(apiStatus, forKey: "primaryDevice")
                alertMessage = deviceData.message ?? "Updated successfully"
            } catch {
                alertMessage = "Something went wrong: \(error.localizedDescription)"
            }
            showAlert = true
            isLoading = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isUpdatingprimaryDevice = false
            }
        }
    }
    
    //MARK: - Update Location Sharing API
    
    func updateLocationSharing(isOn: Bool) {
        
        isLoading = true
    
        let params: [String: Any] = [
            "DeviceId": shortDeviceId(),
            "IsActive": isOn ? "1" : "0"
        ]
        
        print("the location sharing params is \(params)")
        
        Task {
            do {
                let locationData = try await APIFunction.locationSharingAPICalling(params: params)
                print("the location sharing data is \(locationData)")
                isUpdatingLocation = true
                let apiStatus = locationData.MessageStatus
                shareLocation = (apiStatus != nil)
                UserDefaults.standard.set(apiStatus, forKey: "shareLocation")
                alertMessage = locationData.Message ?? "Updated successfully"
            } catch {
                alertMessage = "Something went wrong: \(error.localizedDescription)"
            }
            showAlert = true
            isLoading = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isUpdatingLocation = false
            }
        }
    }
    
    //MARK: - Push Notification API
    
    func updatePushNotification(isOn: Bool) {
        
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("User ID not found or not an Int")
            return
        }
        
        let name = UserDefaults.standard.string(forKey: "firstName") ?? ""
        
        isLoading = true
    
        let params: [String: Any] = [
            "cand_id": "\(userId)",
            "push_notification": isOn ? "1" : "0",
            "cand_name": name
        ]
        
        print("the push notification params is \(params)")
        
        Task {
            do {
                let pushData = try await APIFunction.pushNotificationAPICalling(params: params)
                print("the location data is \(pushData)")
                isUpdateNotification = true
                let apiStatus = pushData.MessageStatus
                appNotifications = (apiStatus != 0)
                UserDefaults.standard.set(apiStatus, forKey: "appNotifications")
                alertMessage = pushData.PushNotificationMessage
            } catch {
                alertMessage = "Something went wrong: \(error.localizedDescription)"
            }
            showAlert = true
            isLoading = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isUpdateNotification = false
            }
        }
    }
    
    //MARK: - Settings overall API
    
    func settingsOverallAPI() {
        
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("User ID not found or not an Int")
            return
        }
        
        isLoading = true
        
        let params: [String: Any] = [
            "candidateId": "\(userId)",
            "deviceId": shortDeviceId(),
        ]
        
        print("the settings overall params is \(params)")
        
        Task {
            do {
                let overallData = try await APIFunction.settingsAPICalling(params: params)
                
                print("the settings overall data is \(overallData)")
                isInitialLoad = true
                print("the initisl load is, \(isInitialLoad)")
                
                shareLocation = (overallData.loactionTrackingResponse?.locationStatus == 1)
                appNotifications = (overallData.pushNotificationMessage?.pushNotificationStatus == 1)
                primaryDevice = (overallData.primaryDeviceMessage?.messageStatus == 1)
                
                if !appNotifications {
                    showAlert = true
                    alertMessage = overallData.pushNotificationMessage?.pushNotificationMessage ?? ""
                }
     
            } catch {
                alertMessage = "Something went wrong: \(error.localizedDescription)"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isInitialLoad = false
                print("the initisl load is, \(self.isInitialLoad)")
            }
            
            
            isLoading = false
        }
    }
}
