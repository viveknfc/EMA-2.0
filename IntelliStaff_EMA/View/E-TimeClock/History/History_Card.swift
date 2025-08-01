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
    
    let items: [ModalItem] = [
        .init(title: "NFC Solutions", imageName: "star"),
        .init(title: "Management", imageName: "heart"),
        .init(title: "01/08/2025", imageName: "calendar"),
        .init(title: "Clock In: 09:00 AM", imageName: "clock"),
        .init(title: "Lunch Out: 1:00 PM", imageName: "clock"),
        .init(title: "Lunch In: 2:00 PM", imageName: "clock"),
        .init(title: "Clock Out: 06:00 PM", imageName: "clock")
    ]
    
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
    History_Card()
}
