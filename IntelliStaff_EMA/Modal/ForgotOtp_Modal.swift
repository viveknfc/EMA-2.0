//
//  ForgotOtp_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 09/09/25.
//

struct ForgotOtpResponse: Codable {
    var code: String?
    var message: String?
    var ttl: String?
}

struct UpdatePasswordResponse: Codable {
    var message: String?
}
