//
//  Dashboard_Screen.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 19/07/25.
//

import SwiftUI

struct Dashboard_Screen: View {
    
    @Bindable var viewModel: DashboardViewModel // ✅ USE THIS
    @State private var showToast = false
    @State private var toastMessage = ""
    @Binding var selectedAssignment: Dashboard_Menu_Items?
    @Binding var showSheet: Bool
    
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 16) {
                    
                    // 1. Small View
                    Image("Splash")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)

//                    // 2. Medium View
//                    Rectangle_Container(alignment: .topLeading) {
//                        AssignmentList_View()
//                    }
//                    .frame(height: 200)

                    // 3. Large View
                    Rectangle_Container {
                        ScrollView {
                            Dashboard_Menu_Collection(
                                assignments: viewModel.dashboardMenuItems,
                                showToast: $showToast,
                                toastMessage: $toastMessage,
                                selectedAssignment: $selectedAssignment, showSheet: $showSheet
                            )
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchDashboard()
                }
                .task {
                    await viewModel.multipleDeviceAPI()
                }

                if showToast {
                    Toast_View(message: toastMessage)
                        .zIndex(1)
                        .position(x: geo.size.width / 2, y: geo.size.height - 60)
                }
                
                

            }
            .animation(.easeInOut, value: selectedAssignment)
            .onChange(of: viewModel.showAlert) { _, newValue in
                if newValue {
                    showAlert = true
                    alertMessage = viewModel.alertMessage
                    viewModel.showAlert = false
                }
            }
        }
    }
}

#Preview {
    struct DashboardScreenPreviewWrapper: View {
        @State private var selectedAssignment: Dashboard_Menu_Items? = nil
        @State private var showSheet: Bool = false // ✅ Added
        @State private var showAlert: Bool = false
        @State private var alertMessage = ""

        var body: some View {
            let sampleChildren = [
                ChildItem(name: "Algebra", imageName: "banknote", apiKey: "link"),
                ChildItem(name: "Geometry", imageName: "banknote", apiKey: "link"),
                ChildItem(name: "Trigonometry", imageName: "banknote", apiKey: "link")
            ]

            let sampleAssignments: [Dashboard_Menu_Items] = [
                Dashboard_Menu_Items(title: "Math", imageName: "book.closed", itemCount: 4, children: sampleChildren),
                Dashboard_Menu_Items(title: "Science", imageName: "flask.fill", itemCount: 2, children: sampleChildren),
                Dashboard_Menu_Items(title: "History", imageName: "clock", itemCount: 0, children: nil),
                Dashboard_Menu_Items(title: "Art", imageName: "paintbrush", itemCount: 5, children: sampleChildren),
                Dashboard_Menu_Items(title: "PE", imageName: "figure.walk", itemCount: 3, children: sampleChildren),
                Dashboard_Menu_Items(title: "Music", imageName: "music.note", itemCount: 1, children: sampleChildren)
            ]

            let viewModel = DashboardViewModel()
            viewModel.dashboardMenuItems = sampleAssignments

            return Dashboard_Screen(
                viewModel: viewModel,
                selectedAssignment: $selectedAssignment,
                showSheet: $showSheet, // ✅ Passed binding
                showAlert: $showAlert,
                alertMessage: $alertMessage
            )
        }
    }

    return DashboardScreenPreviewWrapper()
}
