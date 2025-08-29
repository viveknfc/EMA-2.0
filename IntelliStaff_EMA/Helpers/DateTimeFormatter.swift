//
//  DateTimeFormatter.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 11/08/25.
//
import Foundation

struct DateTimeFormatter {
    static func formattedDate(_ dateString: String?) -> String {
        guard let dateString,
              let date = ISO8601DateFormatter().date(from: dateString) else { return "-" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    static func formattedTime(_ dateString: String?) -> String {
        guard let dateString,
              let date = ISO8601DateFormatter().date(from: dateString) else { return "-" }
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
    
    static func serverDate(_ date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }

    static func serverDateTime(_ date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm a"
        return formatter.string(from: date)
    }
    
    static func nowForServer() -> String {
        ISO8601DateFormatter().string(from: Date())
    }
}

