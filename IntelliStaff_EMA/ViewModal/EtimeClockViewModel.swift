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
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var fullAddress: String = ""
    @Published var isETCCheck: Int = 0
    @Published var activeOrderId: Int = 0
    @Published var showLunchButtons: Bool = false
    @Published var isMultipleLunch: Bool = false
    @Published var showMainLayout: Bool = true
    @Published var noDataMessage: String = ""
    @Published var retryCount: Int = 0
    private var cancellables = Set<AnyCancellable>()
    @Published var candidateId: String?
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var navigateToSettings: Bool = false
    
    // Button state flags (like updateButtonState in Android)
    @Published var isLoginDone: Bool = false
    @Published var isLunchOutDone: Bool = false
    @Published var isLunchInDone: Bool = false
    @Published var isLogOutDone: Bool = false
    
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        
    }
    
    
    func parseGetResponse(model: GetETCDetailsResponse) {
           isETCCheck = model.etcCheck
           showLunchButtons = model.showLunchButtons != 0
           isMultipleLunch = model.isMultipleLunch == 1
           activeOrderId = model.activeOrder
           
           guard activeOrderId == 0 else {
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
                   isETCCheck = order.isETCcheck ?? 0
                   activeOrderId = order.orderId ?? 0
                   // TODO: Handle multiple/single lunch based on order
               }
           } else {
               showMainLayout = false
               noDataMessage = model.message ?? ""
           }
       }
    // MARK: - API Calls
    
    func logTimeApiCall(mode: String) async {
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
            "OrderId": activeOrderId,
            "entereddate": sdfDate,
            "Mode": mode,
            "Retry": retryCount,
            "DeviceId": shortDeviceId(),
            "Log_in": mode == "login" ? sdfDateTime : "",
            "Lunch_out": mode == "lunchout" ? sdfDateTime : "",
            "Lunch_in": mode == "lunchin" ? sdfDateTime : "",
            "Log_out": mode == "logout" ? sdfDateTime : "",
            "Lunch_out2": mode == "lunchout2" ? sdfDateTime : "",
            "Lunch_in2": mode == "lunchin2" ? sdfDateTime : "",
            "ETCcheck": isETCCheck,
            "latitude": coordinate.latitude ?? "",
            "longitude": coordinate.longitude ?? "",
            "Address": address]
        
        
       print("✅ params: \(request)")
            let response = try await APIFunction.eTimeClockCandLogAPICalling(params:  request, token: "\(userId):")
           
            retryCount = response.retry
            print(response)
            if response.successStatus == 0 {

                showAlert = true
                alertMessage = response.message ?? ""
               // await getETCDetails(clientId: candidate.clientId)
            }else if response.successStatus  == 1{
               
                showAlert = true
                alertMessage = response.message ?? ""
            }

            else {
                if response.retry == 1 {
                    try await Task.sleep(nanoseconds: UInt64(response.sleep) * 1_000_000_000)
                    await logTimeApiCall(mode: mode)
                } else {
                   
                    showAlert = true
                    alertMessage = response.message ?? "Failed"
                    if response.message?.contains("Do you want to set this device as primary") == true {
                       // navigateToSettings = true
                    } else {
                       // await getETCDetails(clientId: candidate.clientId)
                    }
                }
            }
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
        ]
        
       
            let response = try await APIFunction.eTimeClockETCDetailsAPICalling(params: request, token: "\(userId):")
            activeOrderId = response.activeOrder
            isETCCheck = response.etcCheck
            
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
