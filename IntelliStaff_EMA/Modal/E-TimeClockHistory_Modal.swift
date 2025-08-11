//
//  E-TimeClockHistory_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 11/08/25.
//

import Foundation

struct ETimeclock_History_Modal: Codable, Identifiable {
    var id: Int?
    let timeId: Int?
    let candidateId: Int?
    let candidateName: String?
    let wDate: String?
    let logIn: String?
    let lunchOut: String?
    let lunchIn: String?
    let logOut: String?
    let sent: Bool?
    let weekend: String?
    let orderId: Int?
    let isSubmitted: Int?
    let pendingTimeId: Int?
    let approvedTimeId: Int?
    let isEdited: Int?
    let isNewTimeEntry: Int?
    let isPopupSubmitted: Int?
    let lunchOut2: String?
    let lunchIn2: String?
    let isIntellistaff: Bool?
    let userID: Int?
    let approvalStatus: String?
    let loggedAddress: String?
    let comments: String?
    let changeFound: Bool?
    let changedBy: String?
    let returnMessage: String?
    let breakMinutes: Int?
    let totalTime: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case timeId = "TimeId"
        case candidateId = "CandidateId"
        case candidateName = "CandidateName"
        case wDate = "WDate"
        case logIn = "LogIn"
        case lunchOut = "LunchOut"
        case lunchIn = "LunchIn"
        case logOut = "LogOut"
        case sent
        case weekend
        case orderId = "OrderId"
        case isSubmitted = "IsSubmitted"
        case pendingTimeId = "PendingTimeId"
        case approvedTimeId = "ApprovedtimeId"
        case isEdited = "IsEdited"
        case isNewTimeEntry = "isNewtimeentry"
        case isPopupSubmitted = "IspopupSubmitted"
        case lunchOut2 = "LunchOut2"
        case lunchIn2 = "LunchIn2"
        case isIntellistaff
        case userID = "UserID"
        case approvalStatus = "ApprovalStatus"
        case loggedAddress
        case comments = "Comments"
        case changeFound = "ChangeFound"
        case changedBy = "ChangedBy"
        case returnMessage = "ReturnMessage"
        case breakMinutes = "BreakMinutes"
        case totalTime = "TotalTime"
    }
}


