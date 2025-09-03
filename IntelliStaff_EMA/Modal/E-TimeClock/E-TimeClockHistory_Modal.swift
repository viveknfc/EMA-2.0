//
//  E-TimeClockHistory_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 11/08/25.
//

import Foundation

struct ETimeclockHistoryResponse: Codable, Identifiable {
    let id = UUID()
    let pleaseSelectMessage: String?
    let noOrdersMessage: String?
    let login: String?
    let logOut: String?
    let lunchOut: String?
    let lunchIn: String?
    let lunchOut1: String?
    let lunchIn1: String?
    let lunchOut2: String?
    let lunchIn2: String?
    let isEnterNewDayShow: Int?
    let submitTimesheet: String?
    let candidateId: Int?
    let weekendDate: String?
    let lstETimeClockViewHistory: [ETimeclock_History_Modal]?
    let messageStatus: Int?
    let message: String?
    let historyMessage: String?
    let totalHour: Int?
    let enterNewDay: String?
    let minutesStepCount: Int?
    let colourText: [ColourText]?
    let isMultipleLunch: Int?

    enum CodingKeys: String, CodingKey {
        case pleaseSelectMessage = "PleaseSelectMessage"
        case noOrdersMessage = "NoOrdersMessage"
        case login = "Login"
        case logOut = "LogOut"
        case lunchOut = "LunchOut"
        case lunchIn = "LunchIn"
        case lunchOut1 = "LunchOut1"
        case lunchIn1 = "LunchIn1"
        case lunchOut2 = "LunchOut2"
        case lunchIn2 = "LunchIn2"
        case isEnterNewDayShow
        case submitTimesheet = "SubmitTimesheet"
        case candidateId = "CandidateId"
        case weekendDate = "WeekendDate"
        case lstETimeClockViewHistory = "LstETimeClockViewHistory"
        case messageStatus = "MessageStatus"
        case message = "Message"
        case historyMessage = "History_Message"
        case totalHour = "TotalHour"
        case enterNewDay = "EnterNewDay"
        case minutesStepCount = "MinutesStepCount"
        case colourText = "ColourText"
        case isMultipleLunch = "IsMultipleLunch"
    }
}

struct ColourText: Codable, Identifiable {
    let id = UUID()
    let text: String?
    let color: String?

    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case color = "Color"
    }
}

struct ETimeclock_History_Modal: Codable, Identifiable {
    var id: Int { timeId ?? 0 } // Use TimeId as unique identifier
    let timeId: Int?
    let candId: Int?
    let workingDate: String?
    let logIn: String?
    let lunchOut: String?
    let lunchIn: String?
    let lunchOut2: String?
    let lunchIn2: String?
    let logOut: String?
    let sent: Int?
    let orderId: Int?
    let comments: String?
    let isETCcheck: Int?
    let hour: Int?
    let isNote: Int?
    let isEdit: Int?
    let etcLogId: Int?
    let isSubmitted: Int?
    let isRejected: Int?
    let isApproved: Int?
    let isValidToSubmit: Int?
    let errorMessage: String?
    let colorCode: String?
    let conflictMessage: String?
    let isMultipleLunch: Int?

    enum CodingKeys: String, CodingKey {
        case timeId = "TimeId"
        case candId = "Cand_id"
        case workingDate = "workingDate"
        case logIn = "Log_In"
        case lunchOut = "Lunch_Out"
        case lunchIn = "Lunch_In"
        case lunchOut2 = "Lunch_Out2"
        case lunchIn2 = "Lunch_In2"
        case logOut = "Log_Out"
        case sent = "Sent"
        case orderId = "OrderId"
        case comments = "Comments"
        case isETCcheck = "isETCcheck"
        case hour = "Hour"
        case isNote = "isNote"
        case isEdit = "isEdit"
        case etcLogId = "ETCLogId"
        case isSubmitted = "IsSubmitted"
        case isRejected = "IsRejected"
        case isApproved = "IsApproved"
        case isValidToSubmit = "IsvalidToSubmit"
        case errorMessage = "ErrorMessage"
        case colorCode = "ColorCode"
        case conflictMessage = "ConflictMessage"
        case isMultipleLunch = "IsMultipleLunch"
    }
}


