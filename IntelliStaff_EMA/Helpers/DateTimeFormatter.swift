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
    
    static func formattedDateTime(_ isoString: String?) -> String {
        guard let isoString = isoString else { return "--" }
        
        let parser = DateFormatter()
        parser.locale = Locale(identifier: "en_US_POSIX")
        parser.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        // If the server time is UTC use TimeZone(secondsFromGMT: 0)
        // If it's local time use TimeZone.current
        parser.timeZone = TimeZone.current
        
        guard let date = parser.date(from: isoString) else { return "--" }
        
        let output = DateFormatter()
        output.dateStyle = .medium
        output.timeStyle = .short
        output.locale = Locale.current
        output.timeZone = TimeZone.current
        return output.string(from: date)
    }

    static func serverDate(_ date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    static func serverDateNw(_ date: Date = Date()) -> String {
        // Subtract 5 hours (18000 seconds)
        let adjustedDate = date.addingTimeInterval(-5 * 60 * 60)
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // ✅ includes milliseconds
        return formatter.string(from: adjustedDate)
    }
    
    static func weekendDate(from date: Date = Date()) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        
        // Calculate days to add to get to Saturday (7) or Sunday (1)
        let weekday = components.weekday ?? 1
        let daysToAdd = weekday == 7 ? 0 : 7 - weekday // Saturday
        // If you want Sunday instead, use: let daysToAdd = weekday == 1 ? 0 : 8 - weekday
        
        if let saturday = calendar.date(byAdding: .day, value: daysToAdd, to: date) {
            // Set hour, minute, second, nanosecond to 0
            let finalDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: saturday)!
            
            // Format to desired string
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            return formatter.string(from: finalDate)
        }
        
        return ""
    }

    static func weekendDateString(from date: Date) -> String {
        let calendar = Calendar.current
        // Ensure time is set to 00:00:00
        let startOfDay = calendar.startOfDay(for: date)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return formatter.string(from: startOfDay)
    }

    static func serverDateTime(_ date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy hh:mm a"
        return formatter.string(from: date)
    }
    
    static func nowForServer() -> String {
        ISO8601DateFormatter().string(from: Date())
    }
    
    static func isoDateTime(_ date: Date = Date()) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter.string(from: date)
    }
}

