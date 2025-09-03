//
//  IntelliStaff_EMAApp.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 14/07/25.
//

import SwiftUI
import UserNotifications

@main
struct IntelliStaff_EMAApp: App {
    
    @StateObject private var errorHandler = GlobalErrorHandler()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        NetworkMonitor.start() // ✅ Start monitoring here
    }
    
    var body: some Scene {
        WindowGroup {
            Spalsh_Screen()
                .environmentObject(errorHandler)
        }
    }
}
