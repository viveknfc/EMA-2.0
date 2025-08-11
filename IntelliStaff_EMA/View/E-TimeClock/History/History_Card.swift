//
//  History_Card.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 31/07/25.
//

import SwiftUI

struct ModalItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct History_Card: View {
    
    let entry: ETimeclock_History_Modal
    

    private func safeFormattedDate(_ dateString: String?) -> String {
        if let dateString = dateString, !dateString.isEmpty {
            return DateTimeFormatter.formattedDate(dateString)
        }
        return "01 Jan 2000"  // your default date string
    }

    private func safeFormattedTime(_ timeString: String?) -> String {
        if let timeString = timeString, !timeString.isEmpty {
            return DateTimeFormatter.formattedTime(timeString)
        }
        return "00:00"  // your default time string
    }

    private var items: [ModalItem] {
        [
            .init(title: entry.candidateName ?? "NFC Solutions", imageName: "star"),
            .init(title: "Management", imageName: "heart"),
            .init(title: safeFormattedDate(entry.wDate), imageName: "calendar"),
            .init(title: "Clock In: \(safeFormattedTime(entry.logIn))", imageName: "clock"),
            .init(title: "Lunch Out: \(safeFormattedTime(entry.lunchOut))", imageName: "clock"),
            .init(title: "Lunch In: \(safeFormattedTime(entry.lunchIn))", imageName: "clock"),
            .init(title: "Clock Out: \(safeFormattedTime(entry.logOut))", imageName: "clock")
        ]
    }


    
    var body: some View {
        Rectangle_Container {
            VStack(spacing: 16) {
                ForEach(items) { item in
                    HStack(spacing: 12) {
                        Image(systemName: item.imageName)
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.theme)
                        Text(item.title)
                            .font(.bodyFont)
                        Spacer()
                    }
                    DottedLine()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 8]))
                        .foregroundColor(.gray)
                        .frame(height: 1)
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    History_Card(entry: ETimeclock_History_Modal(
        id: 1,
        timeId: 123,
        candidateId: 456,
        candidateName: "John Doe",
        wDate: "2024-06-04T00:00:00",
        logIn: "2024-06-04T08:34:00",
        lunchOut: "2024-06-04T13:17:00",
        lunchIn: "2024-06-04T13:47:00",
        logOut: "2024-06-04T17:00:00",
        sent: true,
        weekend: "No",
        orderId: 789,
        isSubmitted: 1,
        pendingTimeId: nil,
        approvedTimeId: 111,
        isEdited: 0,
        isNewTimeEntry: 1,
        isPopupSubmitted: 0,
        lunchOut2: nil,
        lunchIn2: nil,
        isIntellistaff: false,
        userID: 10,
        approvalStatus: "Approved",
        loggedAddress: "123 Main St",
        comments: "No issues",
        changeFound: false,
        changedBy: nil,
        returnMessage: nil,
        breakMinutes: 30,
        totalTime: "7:30"
    ))
}

