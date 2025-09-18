//
//  API_Constants.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 16/07/25.
//

enum APIConstants {
    
    static var DevelopmentURL = "https://tempositionsdev.com/"
    static var ProducitonURL = "https://apps.tempositions.com/"
    static var UATURL = "https://api.tempositions.com/"
    static let baseURL = UATURL
    
    static var accessToken = ""
    
    static var ForgotPasswordOtp = "authuat/api/User/sendotp" //auth/api/
    static var UpdatePassword = "authuat/api/User/updatepassword" //auth/api/
    
    static let ServiceAuthAPI = "User/ServiceAuth" //auth/api/
    static var LoginAPI = "authuat/api/User/token" //auth/api/
    
    static var EMADashboardDetails = "candidateapiuat/api/Candidate/GetEMADashboardDetails"
    static var CandidateDetailsAPI = "candidateapiuat/api/Candidate/CandidateDetails"
    static var demoGraphicDetailsAPI = "eregisterapiuat/api/personalInfo/demographics"
    
    static var ETimeClockHistory = "TimesheetApiuat/api/WebETimeClock/GetViewHistory"
    
    static var GetETCDetails = "TimesheetApiuat/api/WebETimeClock/GetETCDetails"
    static var EtimeClockCandLogTimes = "TimesheetApiuat/api/WebETimeClock/EtimeClockCandLogTimes"
    
    static var primaryDevice = "TimesheetApiuat/api/WebETimeClock/Updatecandidateprimarydevice"
    static var locationSharingAPI = "TimesheetApiuat/api/WebETimeClock/updatecandidatedeviceActiveinfo"
    static var pushNotificationAPI = "TimesheetApiuat/api/WebETimeClock/InsertPushNotificationdetails"
    static var settingsOverall = "TimesheetApiuat/api/WebETimeClock/GetPushNotificationPrimraryDeviceLocationTrackingDetails"
    
    static var multipleDeviceAPI = "TimesheetApiuat/api/WebETimeClock/GetStatusCandidatedevice"
}
