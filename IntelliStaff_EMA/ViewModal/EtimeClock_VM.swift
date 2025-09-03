//
//  EtimeClockViewModel.swift
//  IntelliStaff_EMA
//
//  Created by ios on 21/08/25.
//

import SwiftUI
import CoreLocation

// MARK: - ViewModel

@MainActor
@Observable
class ETimeClockViewModel {
    
    var showMainLayout: Bool = false
    var noDataMessage: String = ""
    var showAlert: Bool = false
    var alertMessage: String = ""
//    var navigateToSettings: Bool = false
    var showPrimaryAlert: Bool = false
    
    var getLogTimeRequest:LogTimeRequest?
    var logTimeResponse: ETimeClockResponse?
    
    var isLoginDone: Bool = false
    var isLunchOutDone: Bool = false
    var isLunchInDone: Bool = false
    var isLogOutDone: Bool = false
    
    var isLoading = false
    
    //MARK: - E-Time Clock Submit Button API
    
    func logTimeApiCall(mode: String, isRetry: Bool = false) async {
        isLoading = true
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("❌ User ID not found")
            return
        }
        
        do {
            let locationManager = SimpleLocationManager()
            let coordinate = try await locationManager.getLocation()
            let address = try await locationManager.getAddress()
            
            let now = Date()
            let time = DateTimeFormatter.serverDateTime(now) // "MM/dd/yyyy hh:mm a"
            let entered = DateTimeFormatter.isoDateTime(now) // ISO with ms + Z

            let request = LogTimeRequest(
                candidateId: "\(userId)",
                orderId: getLogTimeRequest?.orderId,
                enteredDate: entered,
                mode: mode,
                retry: getLogTimeRequest?.retry,
                deviceId: shortDeviceId(),
                logIn: mode == "login" ? time : "",
                lunchOut: mode == "lunchout" ? time : "",
                lunchIn: mode == "lunchin" ? time : "",
                logOut: mode == "logout" ? time : "",
                lunchOut2: mode == "lunchout2" ? time : "",
                lunchIn2: mode == "lunchin2" ? time : "",
                etcCheck: getLogTimeRequest?.etcCheck,
                latitude: "\(coordinate.latitude)",
                longitude: "\(coordinate.longitude)",
                address: address,
                showLunchButtons: nil,   // or a value if you have one
                isMultipleLunch: nil,    // or a value if you have one
                activeOrderId: nil       // or a value if you have one
            )

            
            // Convert to dictionary (if needed)
            guard let dict = request.asDictionary() else {
                print("❌ Failed to encode request")
                return
            }
            
            print("📤 Request: \(dict)")
            
            let response = try await APIFunction.eTimeClockCandLogAPICalling(params: dict)
            logTimeResponse = response
            
            print("the response of logTimeApiCall is \(response)")
            
            if response.retry == 1 && !isRetry {
                await logTimeApiCall(mode: mode, isRetry: true)
                return
            }
            
            if response.message?.contains("primary") == true {
                self.alertMessage = response.message ?? "Do you want to set this device as primary?"
                self.showPrimaryAlert = true
            } else {
                self.alertMessage = response.message ?? ""
                self.showAlert = true
            }
            
            await getETCDetails(clientId: 0)
            
        } catch {
            self.alertMessage = error.localizedDescription
            self.showAlert = true
        }
        isLoading = false
    }
    
    //MARK: - ETC Details API
    
    func getETCDetails(clientId: Int) async {
        isLoading = true
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("User ID not found or not an Int")
            return
        }
        do {
            let locationManager = SimpleLocationManager()
            let coordinate = try await locationManager.getLocation()
            print("✅ Got location: \(coordinate.latitude), \(coordinate.longitude)")
            
            let request:[String:Any] = [
                "CandidateId": userId,
                "ClientId": clientId == 0 ? 0 : clientId,
                "longitude": "\(coordinate.longitude)",
                "latitude": "\(coordinate.latitude)",
                "PositionCheck": 0,
                "PositionId": 0,
                "entereddate": DateTimeFormatter.serverDateNw()
            ]
            
//            let request: [String:Any] = [  "CandidateId": 363943,
//                             "ClientId": 0,
//                             "PositionCheck": 0,
//                             "PositionId": 0,
//                             "entereddate": "2025-09-01T10:00:39.076Z",
//                             "latitude": "",
//                             "longitude": ""]
            
            print("the ETC details request is \(request)")
            
            let response = try await APIFunction.eTimeClockETCDetailsAPICalling(params: request)
            
            print("the etc response is \(response)")
            
            // ✅ Check for orders
            if let firstOrder = response.lstETimeClockCandOrders?.first {
                getLogTimeRequest = LogTimeRequest(
                    candidateId: "\(response.candidateId)",
                    orderId: "\(firstOrder.orderId ?? 0)", // use orderId from first order
                    enteredDate: response.enteredDate ?? "",
                    mode: response.mode ?? "",
                    retry: "\(response.retry)",
                    deviceId: response.deviceId ?? "",
                    logIn: response.logIn ?? "",
                    lunchOut: response.lunchOut ?? "",
                    lunchIn: response.lunchIn ?? "",
                    logOut: response.logOut ?? "",
                    lunchOut2: response.lunchOut2 ?? "",
                    lunchIn2: response.lunchIn2 ?? "",
                    etcCheck: "\(firstOrder.isETCcheck ?? 0)", // from order
                    latitude: "\(coordinate.latitude)",
                    longitude: "\(coordinate.longitude)",
                    address: "",
                    showLunchButtons: response.showLunchButtons,
                    activeOrderId: firstOrder.orderId // from order
                )
                
                showMainLayout = true
                noDataMessage = ""
            } else {
                // no orders found
                showMainLayout = false
                noDataMessage = response.message ?? "No orders available"
            }
//            print("the response for etc details is \(response)")
            print("the order id is", getLogTimeRequest?.orderId ?? 0)
            
            // ✅ Button states
            isLoginDone = response.isLogin == 1
            isLunchOutDone = response.isLunchOut == 1
            isLunchInDone = response.isLunchIn == 1
            isLogOutDone = response.isLogOut == 1
            
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
        isLoading = false
    }
    
}
