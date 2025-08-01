//
//  History_View.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 31/07/25.
//

import SwiftUI

struct History_View: View {
    @State private var showDatePicker = false
    @State private var selectedDate: Date? = nil

    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isSelectingStartDate = true
    
    @State private var toastMessage = ""
    @State private var showToast = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 20) {
                    HStack(spacing: 16) {
                        // Start Date Field
                        Button(action: {
                            isSelectingStartDate = true
                            showDatePicker = true
                        }) {
                            HStack {
                                Text(startDate != nil ? formattedDate(startDate!) : "Start Date")
                                    .foregroundColor(startDate == nil ? .gray : .black)
                                    .font(.buttonFont)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: "calendar")
                                    .foregroundColor(.theme)
                            }
                            .padding()
                            .frame(height: 40)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        }
                        
                        // End Date Field - same structure with fixed width
                        Button(action: {
                            isSelectingStartDate = false
                            showDatePicker = true
                        }) {
                            HStack {
                                Text(endDate != nil ? formattedDate(endDate!) : "End Date")
                                    .foregroundColor(endDate == nil ? .gray : .black)
                                    .font(.buttonFont)
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: "calendar")
                                    .foregroundColor(.theme)
                            }
                            .padding()
                            .frame(height: 40)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                        }
                    }
                    
                    // MARK: - Scrollable History Cards
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(0..<5) { _ in
                                History_Card()
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 80)
                    }
                    
                }
                .padding(.top, 20)
                .padding()
                
                // Date Picker Overlay
                if showDatePicker {
                    
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                showDatePicker = false
                            }
                        
                        VStack {
                            Custom_Calander_View(
                                showDatePicker: $showDatePicker,
                                selectedDate: $selectedDate
                            ){ date in
                                selectedDate = date
                                
                                if isSelectingStartDate {
                                    if let end = endDate, Calendar.current.isDate(date, inSameDayAs: end) || date > end {
                                        toastMessage = "Start date cannot be same as or after end date."
                                        showToast = true
                                    } else {
                                        startDate = date
                                        print("Start Date Selected: \(formattedDate(date))")
                                        showDatePicker = false
                                    }
                                } else {
                                    if let start = startDate, Calendar.current.isDate(date, inSameDayAs: start) || date < start {
                                        toastMessage = "End date cannot be same as or before start date."
                                        showToast = true
                                    } else {
                                        endDate = date
                                        print("End Date Selected: \(formattedDate(date))")
                                        showDatePicker = false
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Add this
                            .clipped()
                        }
                    }
                    .zIndex(10)
                }
            }
            
            // Toast view (on top)
            if showToast {
                Toast_View(message: toastMessage)
                    .zIndex(1)
                    .position(x: geo.size.width / 2, y: geo.size.height - 120)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }
            }
            
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}




#Preview {
    History_View()
}
