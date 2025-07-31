//
//  UserJson.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 28/07/25.
//
import Foundation

struct WebViewPayload {
    let currentUserJson: String
    let keyGuard: String
    let keyName: String
    let accessToken: String
}

func buildWebViewPayload() -> WebViewPayload {
    let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") ?? ""
    let expiresIn = UserDefaults.standard.integer(forKey: "expiresIn")
    let password = UserDefaults.standard.string(forKey: "Password") ?? ""
    let username = UserDefaults.standard.string(forKey: "Username") ?? ""

    // Build JSON for currentUserEWA
    let jsonObject: [String: Any] = [
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "expiresIn": expiresIn,
        "requestingPartyToken": "Bearer",
        "message": "success",
        "isPasswordChange": false,
        "username": username
    ]

    let currentUserJson: String
    if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
       let jsonString = String(data: data, encoding: .utf8) {
        currentUserJson = escapeForJavaScript("\"\(jsonString)\"")
    } else {
        currentUserJson = ""
    }

    return WebViewPayload(
        currentUserJson: currentUserJson,
        keyGuard: escapeForJavaScript(password),
        keyName: escapeForJavaScript(username),
        accessToken: escapeForJavaScript(accessToken)
    )
}

