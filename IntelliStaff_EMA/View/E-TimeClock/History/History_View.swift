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
    
    @State private var toastMessage = ""
    @State private var viewModel = HistoryViewModel()
    
    let candidateID: Int?
    let ssn: String?
    let clientId: Int?
    let lastName: String?
    
    private var nonSundayDates: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let start = calendar.date(byAdding: .year, value: -1, to: today)!
        let end = calendar.date(byAdding: .year, value: 1, to: today)!
        
        var result: [Date] = []
        var current = start
        while current <= end {
            if calendar.component(.weekday, from: current) != 1 { // Not Sunday
                result.append(current)
            }
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        return result
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 20) {
                    HStack(spacing: 16) {
                        // Start Date Field
                        Button(action: {
                            showDatePicker = true
                        }) {
                            HStack {
                                Text(startDate != nil ? formattedDate(startDate!) : "Enter Weekend Date")
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

                    }
                    
                    // MARK: - Scrollable History Cards
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            if viewModel.historyData.first?.lstETimeClockViewHistory?.isEmpty ?? true {
                                Text("No data available")
                                    .foregroundColor(.gray)
                                    .font(.bodyFont)
                                    .padding(.top, 40)
                            } else {
                                ForEach(viewModel.historyData) { entry in
                                    History_Card(entryResponse: entry)
                                }
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
                                selectedDate: $selectedDate,
                                onDateSelection: { date in
                                    selectedDate = date
                                    startDate = date
                                    let formattedWeekend = DateTimeFormatter.weekendDateString(from: date)
                                    print("Start Date Selected: \(formattedWeekend)")
                                    showDatePicker = false
                                    
                                    if let candidateID {
                                           Task {
                                               await viewModel.fetchHistory(
                                                   candidateID: candidateID,
                                                   weekend: formattedWeekend
                                               )
                                           }
                                       }
                                    
                                },
                                disabledDates: nonSundayDates
                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity) // Add this
                            .clipped()

                        }
                    }
                    .zIndex(10)
                }
                
                if viewModel.isLoading {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    TriangleLoader()
                }
                
            }
            .onAppear {

                if let candidateID {
                    let nextSunday = Calendar.current.nextDate(
                        after: Date(),
                        matching: DateComponents(weekday: 1),
                        matchingPolicy: .nextTime
                    ) ?? Date()
                    
                    startDate = nextSunday
                    let startDateString = DateTimeFormatter.weekendDateString(from: nextSunday)
                    
                    Task {
                        await viewModel.fetchHistory(
                            candidateID: candidateID,
                            weekend: startDateString
                        )
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
    History_View(candidateID: 12, ssn: "", clientId: 12, lastName: "")
}
