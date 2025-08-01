//
//  Custom_Calander_View.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 31/07/25.
//

import SwiftUI
import SSDateTimePicker

struct Custom_Calander_View: View {
    @Binding var showDatePicker: Bool
    @Binding var selectedDate: Date?
    
    var onDateSelection: ((Date) -> Void)? = nil

    var body: some View {
        ZStack {
            SSDatePicker(showDatePicker: $showDatePicker)
                .selectedDate(selectedDate)
                .onDateSelection({ date in
                    selectedDate = date
                    onDateSelection?(date)
                })
                .popupOverlayColor(.clear)
//                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill available space
//                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2) 

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
