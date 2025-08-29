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
