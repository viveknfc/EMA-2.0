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
    
    static let ServiceAuthAPI = "auth/api/User/ServiceAuth"
    static var LoginAPI = "auth/api/User/token"
    
    static var EMADashboardDetails = "candidateapi/api/Candidate/GetEMADashboardDetails"
    static var CandidateDetailsAPI = "candidateapi/api/Candidate/CandidateDetails"
    static var demoGraphicDetailsAPI = "eregisterapi/api/personalInfo/demographics"
    
    static var ETimeClockHistory = "TimesheetApi/api/WebETimeClock/GetWebEtimeClockEntries"
    
    static var GetETCDetails = "ETimeClock/GetETCDetails"
    static var EtimeClockCandLogTimes = "ETimeClock/EtimeClockCandLogTimes"
}
