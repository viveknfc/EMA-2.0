//
//  ClockView.swift
//  IntelliStaff_EMA
//
//  Created by ios on 12/08/25.
//

import SwiftUI

struct ClockWheelPickerView: View {
    // MARK: - State
    @State private var selectedHour = 12
    @State private var selectedMinute = 0
    @State private var selectedPeriod = "AM" // Optional for 12-hour format
    
    // MARK: - Data
    let hours = Array(1...12)
    let minutes = Array(0...59)
    let periods = ["AM", "PM"]
    
    var onDone: ((Int, Int, String) -> Void)? // callback when Done is tapped

    var body: some View {
        ZStack(alignment: .bottom){
            Text("Start Time")
                .font(.title2)
                .padding(.top)
            

            HStack(spacing: 0) {
                // Hour Picker
                Picker(selection: $selectedHour, label: Text("Hour")) {
                    ForEach(hours, id: \.self) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)

                Text("")
                    .font(.title)

                // Minute Picker
                Picker(selection: $selectedMinute, label: Text("Minute")) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute)).tag(minute)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)

                // AM/PM Picker (optional)
                Picker(selection: $selectedPeriod, label: Text("AM/PM")) {
                    ForEach(periods, id: \.self) { period in
                        Text(period).tag(period)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(maxWidth: .infinity)
            }
            .frame(height: 280)
            .clipped()
            .padding(.horizontal)

            // Done Button
            Button(action: {
                onDone?(selectedHour, selectedMinute, selectedPeriod)
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.init(hex: "#01377d"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }

            Spacer()
        }
        .padding(.bottom)
    }
}

#Preview {
    ClockWheelPickerView()
}

//struct ContentView: View {
//    @State private var showingPicker = false
//    @State private var selectedTime = ""
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Selected Time: \(selectedTime)")
//                .font(.headline)
//
//            Button("Open Clock Picker") {
//                showingPicker.toggle()
//            }
//
//            if showingPicker {
//                ClockWheelPickerView { hour, minute, period in
//                    selectedTime = String(format: "%02d:%02d %@", hour, minute, period)
//                    showingPicker = false
//                }
//                .transition(.move(edge: .bottom))
//                .animation(.easeInOut, value: showingPicker)
//            }
//        }
//        .padding()
//    }
//}







struct Item: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}

struct CustomCollectionView: View {
    let items: [Item] = [
        Item(imageName: "star", title: "Star"),
        Item(imageName: "heart", title: "Heart"),
        Item(imageName: "flame", title: "Flame"),
        Item(imageName: "bolt", title: "Bolt"),
        Item(imageName: "cloud", title: "Cloud"),
        Item(imageName: "moon", title: "Moon"),
        Item(imageName: "sun.max", title: "Sun"),
        Item(imageName: "leaf", title: "Leaf"),
        Item(imageName: "globe", title: "Globe")
    ]
    
    // 3 columns per row with fixed width
    let columns = [
        GridItem(.fixed(110), spacing: 12),
        GridItem(.fixed(110), spacing: 12),
        GridItem(.fixed(110), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(items) { item in
                    VStack(spacing: 8) {
                        Image(systemName: item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        
                        Text(item.title)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .frame(width: 110, height: 130)
                    .background(Color(hex: "#5D3FD3"))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                }
            }
            .padding()
        }
    }
}

struct CustomCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCollectionView()
    }
}
