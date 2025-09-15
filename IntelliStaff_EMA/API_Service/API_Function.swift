//
//  API_Function.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 16/07/25.
//

import UserNotifications

struct APIFunction {
    
    //MARK: - serviceAuthAPICalling
    
    static func serviceAuthAPICalling() async throws -> TokenResponse {
        let params:[String:String] = ["userData": "N6aM+1OPod0PNWGFb4Xg68jVcwJpeWWzXxtiGXG8VH3VEAZZt7D9VMPnkhHQwxrBn9OI8l5GM73kFTQ4BVJudOoGc1j0dIoFzeY090lHVlRHJIaRCrz/PjuE+MxJrhhs0CayK5EcFVPrOBEsZ6Z4z/PCw/XQZwaESi/YKG+axiCtDAeUOkkArclXAQY+rwPU6Vbg2g3EAKHDb9VK7eCUM80+PFi7QyQi/4vlDaVOnTq6oqgN3VQ3kdcqI4emOySvxGWMiUcWQfONRfU4ImyDbIy98UCNwwoHwKNZnAI/2cDyuEtbA5YtMnq/leaj5L0ZYkzlB3phSaUB93rZorXSaI15KK1aAbgkaVtc+bMFDm/1Wn2sZKySS97KD1CazY9q0PLG5hCA9J2bYYIdzDgGzA=="]
        let url = APIConstants.baseURL + APIConstants.ServiceAuthAPI //APIConstants.baseURL //"https://tempositionsdev.com/"
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Forgot Password Otp API
    
    static func forgotOtpAPICalling(params: [String: Any]) async throws -> ForgotOtpResponse {
        let url = APIConstants.baseURL + APIConstants.ForgotPasswordOtp
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Update Password API
    
    static func updatePasswordAPICalling(params: [String: Any]) async throws -> UpdatePasswordResponse {
        let url = APIConstants.baseURL + APIConstants.UpdatePassword
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Login API
    
    static func loginAPICalling(params: [String: Any]) async throws -> LoginResponse {
        let url = APIConstants.baseURL + APIConstants.LoginAPI //APIConstants.baseURL //"https://tempositionsdev.com/"
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Dashboard API
    
    static func dashboardAPICalling(params: [String: Any]) async throws -> DashboardResponse {
        print("Calling dashboard API with params: \(params)")
        let url = APIConstants.baseURL + APIConstants.EMADashboardDetails
        return try await APIService.request(url: url, method: .post, urlParams: params)
    }
    
    //MARK: - Candidate Id API
    
    static func candidateIdAPICalling(params: [String: Any]) async throws -> CandidateIdModel {
        let url = APIConstants.baseURL + APIConstants.CandidateDetailsAPI
        return try await APIService.request(url: url, urlParams: params)
    }
    
    //MARK: - Demographic Details API
    
    static func demographicAPICalling(params: [String: Any]) async throws -> CandidateInfo {
        let url = APIConstants.baseURL + APIConstants.demoGraphicDetailsAPI
        return try await APIService.request(url: url, urlParams: params)
    }
    
    //MARK: - E-Time clock History API
    
    static func eTimeClockHistoryAPICalling(params: [String: Any]) async throws -> [ETimeclockHistoryResponse] {
        let url = APIConstants.baseURL + APIConstants.ETimeClockHistory
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - E-Time clock API
    
    static func eTimeClockETCDetailsAPICalling(params: [String: Any]) async throws -> GetETCDetailsResponse {
        let url = APIConstants.baseURL + APIConstants.GetETCDetails
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - E-Time clock submit API
    
    static func eTimeClockCandLogAPICalling(params: [String: Any]) async throws -> ETimeClockResponse {
        let url = APIConstants.baseURL + APIConstants.EtimeClockCandLogTimes
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Primary device API
    
    static func primaryDeviceAPICalling(params: [String: Any]) async throws -> DeviceStatusResponse {
        let url = APIConstants.baseURL + APIConstants.primaryDevice
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Location Sharing API
    
    static func locationSharingAPICalling(params: [String: Any]) async throws -> Location_Modal {
        let url = APIConstants.baseURL + APIConstants.locationSharingAPI
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Push Notification API
    
    static func pushNotificationAPICalling(params: [String: Any]) async throws -> PushNotificationModel {
        let url = APIConstants.baseURL + APIConstants.pushNotificationAPI
        return try await APIService.request(url: url, method: .post, parameters: params)
    }
    
    //MARK: - Settings API
    
    static func settingsAPICalling(params: [String: Any]) async throws -> NotificationResponse {
        let url = APIConstants.baseURL + APIConstants.settingsOverall
        return try await APIService.request(url: url, method: .get, urlParams: params)
    }
    
    //MARK: - Multiple Device API
    
    static func multipleDeviceAPICalling(params: [String: Any]) async throws -> MultipleDevice_Modal {
        let url = APIConstants.baseURL + APIConstants.multipleDeviceAPI
        return try await APIService.request(url: url, method: .get, urlParams: params)
    }
    
    static func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Hello 👋"
        content.body = "This is a test notification."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }


    
}
