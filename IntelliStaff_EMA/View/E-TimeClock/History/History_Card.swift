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
    
    let entryResponse: ETimeclockHistoryResponse

    private var items: [ModalItem] {
        guard let history = entryResponse.lstETimeClockViewHistory else { return [] }
        var modalItems: [ModalItem] = []
        
        for entry in history {
            modalItems.append(.init(title: "NFC Solutions", imageName: "person.fill"))
            
            modalItems.append(.init(
                title: "Clock In: \(entry.logIn != nil ? DateTimeFormatter.formattedDateTime(entry.logIn) : "NA")",
                imageName: "clock"
            ))
            
            modalItems.append(.init(
                title: "Lunch Out: \(entry.lunchOut != nil ? DateTimeFormatter.formattedDateTime(entry.lunchOut) : "NA")",
                imageName: "clock"
            ))
            
            modalItems.append(.init(
                title: "Lunch In: \(entry.lunchIn != nil ? DateTimeFormatter.formattedDateTime(entry.lunchIn) : "NA")",
                imageName: "clock"
            ))
            
            modalItems.append(.init(
                title: "Clock Out: \(entry.logOut != nil ? DateTimeFormatter.formattedDateTime(entry.logOut) : "NA")",
                imageName: "clock"
            ))
        }
        
        return modalItems
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

}

