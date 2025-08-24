//
//  Custom_Calander_View.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 31/07/25.
//

import SwiftUI
import SSDateTimePicker
import Foundation
import CryptoKit
import UIKit

struct Custom_Calander_View: View {
    @Binding var showDatePicker: Bool
    @Binding var selectedDate: Date?
    
    var onDateSelection: ((Date) -> Void)? = nil
    var disabledDates: [Date] = []

    var body: some View {
        ZStack {
            SSDatePicker(showDatePicker: $showDatePicker)
                .selectedDate(selectedDate)
                .onDateSelection({ date in
                    selectedDate = date
                    onDateSelection?(date)
                })
                .popupOverlayColor(.clear)
                .disableDates(disabledDates)
        }
    }
}

#Preview {
    Custom_Calendar_Preview_Wrapper()
}

struct Custom_Calendar_Preview_Wrapper: View {
    @State private var showDatePicker = true
    @State private var selectedDate: Date? = nil

    var body: some View {
        Custom_Calander_View(
            showDatePicker: $showDatePicker,
            selectedDate: $selectedDate
        )
    }
}

func shortDeviceId() -> String {
    // Get identifierForVendor (unique per vendor per device)
    let idfv = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    
    // Remove dashes
    let raw = idfv.replacingOccurrences(of: "-", with: "")
    
    // Hash for consistency
    let hash = SHA256.hash(data: raw.data(using: .utf8)!)
    
    // Convert to hex
    let hex = hash.map { String(format: "%02x", $0) }.joined()
    
    // Take first 16 characters
    return String(hex.prefix(16))
}
