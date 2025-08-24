//
//  Settings_Modal.swift
//  IntelliStaff_EMA
//
//  Created by ios on 22/08/25.
//

import Foundation

struct DeviceStatusResponse: Codable {
    let candidateId: Int
    let tenantId: Int
    let deviceId: String
    let osType: String
    let status: Int
    let message: String
    let messageStatus: Int

    enum CodingKeys: String, CodingKey {
        case candidateId = "CandidateId"
        case tenantId = "TenantId"
        case deviceId = "DeviceId"
        case osType = "OSType"
        case status = "Status"
        case message = "Message"
        case messageStatus = "MessageStatus"
    }
}


struct LogTimeRequest: Codable {
    let CandidateId: Int
    let OrderId: Int
    let entereddate: String
    let Mode: String
    var Retry: Int
    let DeviceId: String
    var Log_in: String
    var Lunch_out: String
    var Lunch_in: String
    var Log_out: String
    let Lunch_out2: String
    let Lunch_in2: String
    var etcCheck: Int
    let latitude: Double?
    let longitude: Double?
    var showLunchButtons: Int?
    var isMultipleLunch: Int?
    var activeOrderId: Int
}
