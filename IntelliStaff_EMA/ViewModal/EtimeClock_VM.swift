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
            
            let nowDate = Date()
            let sdfDate = DateTimeFormatter.serverDate(nowDate)
            let sdfDateTime = DateTimeFormatter.serverDateTime(nowDate)
            
            let request = LogTimeRequest(
                candidateId: userId,
                orderId: getLogTimeRequest?.orderId,
                enteredDate: sdfDate,
                mode: mode,
                retry: getLogTimeRequest?.retry,
                deviceId: shortDeviceId(),
                logIn: mode == "login" ? sdfDateTime : "",
                lunchOut: mode == "lunchout" ? sdfDateTime : "",
                lunchIn: mode == "lunchin" ? sdfDateTime : "",
                logOut: mode == "logout" ? sdfDateTime : "",
                lunchOut2: mode == "lunchout2" ? sdfDateTime : "",
                lunchIn2: mode == "lunchin2" ? sdfDateTime : "",
                etcCheck: getLogTimeRequest?.etcCheck,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                address: address
            )
            
            // Convert to dictionary (if needed)
            guard let dict = request.asDictionary() else {
                print("❌ Failed to encode request")
                return
            }
            
            print("📤 Request: \(dict)")
            
            let response = try await APIFunction.eTimeClockCandLogAPICalling(params: dict, token: "\(userId):")
            logTimeResponse = response
            
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
                "ClientId": clientId == 0 ? "" : "\(clientId)",
                "longitude": coordinate.longitude,
                "latitude": coordinate.latitude,
                "PositionCheck": "0",
                "PositionID": "",
                "entereddate": DateTimeFormatter.serverDate()
            ]
            
            print("the ETC details request is \(request)")
            
            let response = try await APIFunction.eTimeClockETCDetailsAPICalling(params: request, token: "\(userId):")
            
            // ✅ Check for orders
            if let firstOrder = response.lstETimeClockCandOrders?.first {
                getLogTimeRequest = LogTimeRequest(
                    candidateId: response.candidateId,
                    orderId: firstOrder.orderId, // use orderId from first order
                    enteredDate: response.enteredDate ?? "",
                    mode: response.mode ?? "",
                    retry: response.retry,
                    deviceId: response.deviceId ?? "",
                    logIn: response.logIn ?? "",
                    lunchOut: response.lunchOut ?? "",
                    lunchIn: response.lunchIn ?? "",
                    logOut: response.logOut ?? "",
                    lunchOut2: response.lunchOut2 ?? "",
                    lunchIn2: response.lunchIn2 ?? "",
                    etcCheck: firstOrder.isETCcheck, // from order
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude,
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

//    func parseGetResponse(model: GetETCDetailsResponse) {
//        
//        getLogTimeRequest?.etcCheck = model.etcCheck - done
//        getLogTimeRequest?.showLunchButtons = model.showLunchButtons - done
//        getLogTimeRequest?.isMultipleLunch = model.isMultipleLunch
//        getLogTimeRequest?.activeOrderId = model.activeOrder - done
//
//                   guard getLogTimeRequest?.activeOrderId == 0 else {
//                       showMainLayout = true
//                       return
//                   }
//        
//                if let clients = model.lstEtimeclockGetClients, !clients.isEmpty {
//                       if clients.count > 1 {
//                           // TODO: Show client selection
//                           print("Multiple clients available. Selection required.")
//                       }
//                } else if let orders = model.lstETimeClockCandOrders, !orders.isEmpty {
//                       showMainLayout = true
//                       if let order = orders.first {
//                           getLogTimeRequest?.etcCheck  = order.isETCcheck ?? 0
//                           getLogTimeRequest?.activeOrderId = order.orderId ?? 0
//                           // TODO: Handle multiple/single lunch based on order
//                       }
//                   } else {
//                       showMainLayout = false
//                       noDataMessage = model.message ?? ""
//        
//           }
//       }
    // MARK: - API Calls
    
//    func logTimeApiCall(mode: String, etimeModel:LogTimeRequest? =  nil) async {
//        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
//            print("User ID not found or not an Int")
//            return
//        }
//        
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        let sdfDate = dateFormatter.string(from: currentDate)
//        
//        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
//        let sdfDateTime = dateFormatter.string(from: currentDate)
//        do {
//        let locationManager = SimpleLocationManager()
//         
//        let coordinate = try await locationManager.getLocation()
//        print("✅ Got location: \(coordinate.latitude), \(coordinate.longitude)")
//            
//            let address = try await locationManager.getAddress()
//                   print("Full address: \(address)")
//        let request:[String:Any] = [
//            "CandidateId": userId,
//            "OrderId": etimeModel?.activeOrderId,
//            "entereddate": sdfDate,
//            "Mode": mode,
//            "Retry": etimeModel?.Retry,
//            "DeviceId": shortDeviceId(),
//            "Log_in": mode == "login" ? sdfDateTime : "",
//            "Lunch_out": mode == "lunchout" ? sdfDateTime : "",
//            "Lunch_in": mode == "lunchin" ? sdfDateTime : "",
//            "Log_out": mode == "logout" ? sdfDateTime : "",
//            "Lunch_out2": mode == "lunchout2" ? sdfDateTime : "",
//            "Lunch_in2": mode == "lunchin2" ? sdfDateTime : "",
//            "ETCcheck": etimeModel?.etcCheck,
//            "latitude": coordinate.latitude ?? "",
//            "longitude": coordinate.longitude ?? "",
//            "Address": address]
//        
//        
//       print("✅ params: \(request)")
//            let response = try await APIFunction.eTimeClockCandLogAPICalling(params:  request, token: "\(userId):")
//            logTimeResponse = response
//            getLogTimeRequest?.Retry = response.retry
//            print(response)
//            
//            
//            
//            if response.successStatus == 1 {
//                            print("✅ Success: \(response.message ?? "")")
//                showAlert = true
//                alertMessage = response.message ?? ""
//                            // TODO: trigger next API if required
//              //  await getETCDetails(clientId: response.clientId ?? 0)
//            } else if response.successStatus == 0{
//                showAlert = true
//                alertMessage = response.message ?? ""
//               // await getETCDetails(clientId: response.clientId ?? 0)
//            }else if response.retry == 1 {
//                            try await Task.sleep(nanoseconds: UInt64(response.sleep) * 1_000_000_000)
//                if let request = getLogTimeRequest{
//                    await logTimeApiCall(mode: mode, etimeModel: request)
//                }
//                        } else {
//                            print("❌ Error: \(response.message ?? "")")
//                            // TODO: Navigate to settings if primary device issue
//                            if response.message?.contains("Do you want to set this device as primary") == true {
//                               navigateToSettings = true
//                               showAlert = true
//                               alertMessage = response.message ?? ""
//                           } else {
//                               await getETCDetails(clientId: 0)
//                           }
//            }
//            await getETCDetails(clientId: 0)
//
//        } catch {
//            alertMessage = error.localizedDescription
//            showAlert = true
//        }
//    }

    
//    func getETCDetails(clientId: Int) async {
//        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
//            print("User ID not found or not an Int")
//            return
//        }
//        do {
//        let locationManager = SimpleLocationManager()
//         
//        let coordinate = try await locationManager.getLocation()
//        print("✅ Got location: \(coordinate.latitude), \(coordinate.longitude)")
//        let request:[String:Any] = [
//            "CandidateId": userId,
//            "ClientId": clientId == 0 ? "" : "\(clientId)",
//            "longitude": coordinate.longitude ?? "",
//            "latitude": coordinate.latitude ?? "",
//            "PositionCheck": "0",
//            "PositionID": "",
//            "entereddate": getTodayDate()
//                //"08/20/2025"
//                //getTodayDate()
//        ]
//            
//            print("the ETC details request is \(request)")
//        
//       
//            let response = try await APIFunction.eTimeClockETCDetailsAPICalling(params: request, token: "\(userId):")
//            getLogTimeRequest = LogTimeRequest(CandidateId: response.candidateId, OrderId: response.activeOrder, entereddate: response.enteredDate ?? "", Mode: response.mode ?? "", Retry: response.retry, DeviceId: response.deviceId ?? "", logIn: response.logIn ?? "", lunchOut: response.lunchOut ?? "", lunchIn: response.lunchIn ?? "", logOut: response.logOut ?? "", lunchOut2: response.lunchOut2 ?? "", lunchIn2: response.lunchIn2 ?? "", etcCheck: response.etcCheck, latitude: coordinate.latitude, longitude: coordinate.longitude, activeOrderId: response.activeOrder, address: "")
//            
//            getLogTimeRequest?.activeOrderId = response.activeOrder
//            getLogTimeRequest?.etcCheck = response.etcCheck
//            
//            print("the response for etc details is \(response)")
//            // ✅ Update button states (updateButtonState equivalent)
//            isLoginDone = response.isLogin == 1
//            isLunchOutDone = response.isLunchOut == 1
//            isLunchInDone = response.isLunchIn == 1
//            isLogOutDone = response.isLogOut == 1
//
//            parseGetResponse(model: response)
//        } catch {
//            alertMessage = error.localizedDescription
//            showAlert = true
//        }
//    }
//    
//    private func getTodayDate() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        return formatter.string(from: Date())
//    }
