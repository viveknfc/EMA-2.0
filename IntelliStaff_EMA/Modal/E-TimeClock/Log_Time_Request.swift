//
//  Log_Time_Request.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 26/08/25.

struct LogTimeRequest: Codable {
    let candidateId: String
    let orderId: String?
    let enteredDate: String
    let mode: String
    let retry: String?
    let deviceId: String
    let logIn: String
    let lunchOut: String
    let lunchIn: String
    let logOut: String
    let lunchOut2: String
    let lunchIn2: String
    var etcCheck: String?
    let latitude: String?
    let longitude: String?
    let address: String?
    
    // Extra API-driven fields
    var showLunchButtons: Int?
    var isMultipleLunch: Int?
    var activeOrderId: Int?
    
    enum CodingKeys: String, CodingKey {
        case candidateId    = "CandidateId"
        case orderId        = "OrderId"
        case enteredDate    = "entereddate"
        case mode           = "Mode"
        case retry          = "Retry"
        case deviceId       = "DeviceId"
        case logIn          = "Log_in"
        case lunchOut       = "Lunch_out"
        case lunchIn        = "Lunch_in"
        case logOut         = "Log_out"
        case lunchOut2      = "Lunch_out2"
        case lunchIn2       = "Lunch_in2"
        case etcCheck       = "ETCcheck"
        case latitude
        case longitude
        case address        = "Address"
        case showLunchButtons
        case isMultipleLunch
        case activeOrderId
    }
}


