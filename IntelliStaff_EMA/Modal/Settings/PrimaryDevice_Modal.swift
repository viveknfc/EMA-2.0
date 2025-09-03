//
//  Settings_Modal.swift
//  IntelliStaff_EMA
//
//  Created by ios on 22/08/25.
//

import Foundation

struct DeviceStatusResponse: Codable {
    let deviceStatus: Int?
    let message: String?
    let messageStatus: Int?

    enum CodingKeys: String, CodingKey {
        case deviceStatus = "DeviceStatus"
        case message = "Message"
        case messageStatus = "MessageStatus"
    }
}
