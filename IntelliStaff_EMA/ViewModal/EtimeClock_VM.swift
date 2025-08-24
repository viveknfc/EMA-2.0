//
//  EtimeClockViewModel.swift
//  IntelliStaff_EMA
//
//  Created by ios on 21/08/25.
//

import SwiftUI
import Combine
import CoreLocation

// MARK: - ViewModel

@MainActor
class ETimeClockViewModel: NSObject, ObservableObject {

    @Published var showMainLayout: Bool = false
    @Published var noDataMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var navigateToSettings: Bool = false
    
    @Published var getLogTimeRequest:LogTimeRequest?
    @Published var logTimeResponse: ETimeClockResponse?
    @Published var isLoginDone: Bool = false
    @Published var isLunchOutDone: Bool = false
    @Published var isLunchInDone: Bool = false
    @Published var isLogOutDone: Bool = false
    @Published var respModel: ETimeClockResponse?
    func parseGetResponse(model: GetETCDetailsResponse) {
//           isETCCheck = model.etcCheck
//           showLunchButtons = model.showLunchButtons != 0
//           isMultipleLunch = model.isMultipleLunch == 1
//           activeOrderId = model.activeOrder
//           
//           guard activeOrderId == 0 else {
//               showMainLayout = true
//               return
//           }
//           
//        if let clients = model.lstEtimeclockGetClients, !clients.isEmpty {
//               if clients.count > 1 {
//                   // TODO: Show client selection
//                   print("Multiple clients available. Selection required.")
//               }
//        } else if let orders = model.lstETimeClockCandOrders, !orders.isEmpty {
//               showMainLayout = true
//               if let order = orders.first {
//                   isETCCheck = order.isETCcheck ?? 0
//                   activeOrderId = order.orderId ?? 0
//                   // TODO: Handle multiple/single lunch based on order
//               }
//           } else {
//               showMainLayout = false
//               noDataMessage = model.message ?? ""
        
        getLogTimeRequest?.etcCheck = model.etcCheck
        getLogTimeRequest?.showLunchButtons = model.showLunchButtons
        getLogTimeRequest?.isMultipleLunch = model.isMultipleLunch
        getLogTimeRequest?.activeOrderId = model.activeOrder
        
                   guard getLogTimeRequest?.activeOrderId == 0 else {
                       showMainLayout = true
                       return
                   }
        
                if let clients = model.lstEtimeclockGetClients, !clients.isEmpty {
                       if clients.count > 1 {
                           // TODO: Show client selection
                           print("Multiple clients available. Selection required.")
                       }
                } else if let orders = model.lstETimeClockCandOrders, !orders.isEmpty {
                       showMainLayout = true
                       if let order = orders.first {
                           getLogTimeRequest?.etcCheck  = order.isETCcheck ?? 0
                           getLogTimeRequest?.activeOrderId = order.orderId ?? 0
                           // TODO: Handle multiple/single lunch based on order
                       }
                   } else {
                       showMainLayout = false
                       noDataMessage = model.message ?? ""
        
           }
       }
    // MARK: - API Calls
    
    func logTimeApiCall(mode: String, etimeModel:LogTimeRequest? =  nil) async {
        guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
            print("User ID not found or not an Int")
            return
        }
        
       // guard let candidate = userId else { return }
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let sdfDate = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let sdfDateTime = dateFormatter.string(from: currentDate)
        do {
        let locationManager = SimpleLocationManager()
         
        let coordinate = try await locationManager.getLocation()
        print("✅ Got location: \(coordinate.latitude), \(coordinate.longitude)")
            
            let address = try await locationManager.getAddress()
                   print("Full address: \(address)")
        let request:[String:Any] = [
            "CandidateId": userId,
            "OrderId": etimeModel?.activeOrderId,
            "entereddate": sdfDate,
            "Mode": mode,
            "Retry": etimeModel?.Retry,
            "DeviceId": shortDeviceId(),
            "Log_in": mode == "login" ? sdfDateTime : "",
            "Lunch_out": mode == "lunchout" ? sdfDateTime : "",
            "Lunch_in": mode == "lunchin" ? sdfDateTime : "",
            "Log_out": mode == "logout" ? sdfDateTime : "",
            "Lunch_out2": mode == "lunchout2" ? sdfDateTime : "",
            "Lunch_in2": mode == "lunchin2" ? sdfDateTime : "",
            "ETCcheck": etimeModel?.etcCheck,
            "latitude": coordinate.latitude ?? "",
            "longitude": coordinate.longitude ?? "",
            "Address": address]
        
        
       print("✅ params: \(request)")
            let response = try await APIFunction.eTimeClockCandLogAPICalling(params:  request, token: "\(userId):")
            logTimeResponse = response
            getLogTimeRequest?.Retry = response.retry
            print(response)
            
            
            
            if response.successStatus == 1 {
                            print("✅ Success: \(response.message ?? "")")
                showAlert = true
                alertMessage = response.message ?? ""
                            // TODO: trigger next API if required
              //  await getETCDetails(clientId: response.clientId ?? 0)
            } else if response.successStatus == 0{
                showAlert = true
                alertMessage = response.message ?? ""
               // await getETCDetails(clientId: response.clientId ?? 0)
            }else if response.retry == 1 {
                            try await Task.sleep(nanoseconds: UInt64(response.sleep) * 1_000_000_000)
                if let request = getLogTimeRequest{
                    await logTimeApiCall(mode: mode, etimeModel: request)
                }
                        } else {
                            print("❌ Error: \(response.message ?? "")")
                            // TODO: Navigate to settings if primary device issue
                            if response.message?.contains("Do you want to set this device as primary") == true {
                               navigateToSettings = true
                               showAlert = true
                               alertMessage = response.message ?? ""
                           } else {
                               await getETCDetails(clientId: 0)
                           }
            }
            await getETCDetails(clientId: 0)

        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    func getETCDetails(clientId: Int) async {
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
            "longitude": coordinate.longitude ?? "",
            "latitude": coordinate.latitude ?? "",
            "PositionCheck": "0",
            "PositionID": "",
            "entereddate": getTodayDate()
                //"08/20/2025"
                //getTodayDate()
        ]
        
       
            let response = try await APIFunction.eTimeClockETCDetailsAPICalling(params: request, token: "\(userId):")
            getLogTimeRequest = LogTimeRequest(CandidateId: response.candidateId, OrderId: response.activeOrder, entereddate: response.enteredDate ?? "", Mode: response.mode ?? "", Retry: response.retry, DeviceId: response.deviceId ?? "", Log_in: response.logIn ?? "", Lunch_out: response.lunchOut ?? "", Lunch_in: response.lunchIn ?? "", Log_out: response.logOut ?? "", Lunch_out2: response.lunchOut2 ?? "", Lunch_in2: response.lunchIn2 ?? "", etcCheck: response.etcCheck, latitude: coordinate.latitude, longitude: coordinate.longitude, activeOrderId: response.activeOrder)
            
            getLogTimeRequest?.activeOrderId = response.activeOrder
            getLogTimeRequest?.etcCheck = response.etcCheck
            
            // ✅ Update button states (updateButtonState equivalent)
            isLoginDone = response.isLogin == 1
            isLunchOutDone = response.isLunchOut == 1
            isLunchInDone = response.isLunchIn == 1
            isLogOutDone = response.isLogOut == 1

            parseGetResponse(model: response)
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
    }
    
    private func getTodayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: Date())
    }
}
