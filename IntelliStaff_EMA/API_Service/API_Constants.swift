//
//  API_Constants.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 16/07/25.
//

enum APIConstants {
    
    static var DevelopmentURL = "https://tempositionsdev.com/"
    static var ProducitonURL = "https://apps.tempositions.com/"
    static let baseURL = DevelopmentURL
    
    static var accessToken = ""
    
    static var ForgotPasswordOtp = "auth/api/User/sendotp"
    static var UpdatePassword = "auth/api/User/updatepassword"
    
    static let ServiceAuthAPI = "auth/api/User/ServiceAuth"
    static var LoginAPI = "auth/api/User/token"
    
    static var EMADashboardDetails = "candidateapi/api/Candidate/GetEMADashboardDetails"
    static var CandidateDetailsAPI = "candidateapi/api/Candidate/CandidateDetails"
    static var demoGraphicDetailsAPI = "eregisterapi/api/personalInfo/demographics"
    
    static var ETimeClockHistory = "TimesheetApi/api/WebETimeClock/GetViewHistory"
    
    static var GetETCDetails = "TimesheetApi/api/WebETimeClock/GetETCDetails"
    static var EtimeClockCandLogTimes = "TimesheetApi/api/WebETimeClock/EtimeClockCandLogTimes"
    
    static var primaryDevice = "TimesheetApi/api/WebETimeClock/Updatecandidateprimarydevice"
    static var locationSharingAPI = "TimesheetApi/api/WebETimeClock/updatecandidatedeviceActiveinfo"
    static var pushNotificationAPI = "TimesheetApi/api/WebETimeClock/InsertPushNotificationdetails"
    static var settingsOverall = "TimesheetApi/api/WebETimeClock/GetPushNotificationPrimraryDeviceLocationTrackingDetails"
    
    static var multipleDeviceAPI = "TimesheetApi/api/WebETimeClock/GetStatusCandidatedevice"
}
