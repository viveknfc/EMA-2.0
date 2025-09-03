//
//  SettingsOverall_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 01/09/25.
//

struct NotificationResponse: Codable {
    let pushNotificationMessage: PushNotificationMessage?
    let primaryDeviceMessage: PrimaryDeviceMessage?
    let loactionTrackingResponse: LocationTrackingResponse?
    
    enum CodingKeys: String, CodingKey {
        case pushNotificationMessage = "pushNotificationMessage"
        case primaryDeviceMessage = "PrimaryDeviceMessage"
        case loactionTrackingResponse = "loactionTrackingResponse"
    }
}

// MARK: - Push Notification Message
struct PushNotificationMessage: Codable {
    let pushNotificationStatus: Int?
    let pushNotificationMessage: String?
    let pushNotificationPopup: Int?
    
    enum CodingKeys: String, CodingKey {
        case pushNotificationStatus = "PushNotificationStatus"
        case pushNotificationMessage = "PushNotificationMessage"
        case pushNotificationPopup = "PushNotificationPopup"
    }
}

// MARK: - Primary Device Message
struct PrimaryDeviceMessage: Codable {
    let messageStatus: Int?
    let message: String?
    let deviceStatus: Int?
    
    enum CodingKeys: String, CodingKey {
        case messageStatus = "MessageStatus"
        case message = "Message"
        case deviceStatus = "DeviceStatus"
    }
}

// MARK: - Location Tracking Response
struct LocationTrackingResponse: Codable {
    let locationStatus: Int?
    let locationMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case locationStatus = "locationStatus"
        case locationMessage = "LocationMessage"
    }
}

