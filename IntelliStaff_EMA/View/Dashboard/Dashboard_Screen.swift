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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 16) {
                    
                    // 1. Small View
                    Image("Splash")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)

                    // 2. Medium View
                    Rectangle_Container(alignment: .topLeading) {
                        AssignmentList_View()
                    }
                    .frame(height: 200)

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

                if showToast {
                    Toast_View(message: toastMessage)
                        .zIndex(1)
                        .position(x: geo.size.width / 2, y: geo.size.height - 60)
                }

            }
            .animation(.easeInOut, value: selectedAssignment)
        }
    }
}

#Preview {
    struct DashboardScreenPreviewWrapper: View {
        @State private var selectedAssignment: Dashboard_Menu_Items? = nil
        @State private var showSheet: Bool = false // ✅ Added

        var body: some View {
            let sampleChildren = [
                ChildItem(name: "Algebra", apiKey: "link"),
                ChildItem(name: "Geometry", apiKey: "link"),
                ChildItem(name: "Trigonometry", apiKey: "link")
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
                showSheet: $showSheet // ✅ Passed binding
            )
        }
    }

    return DashboardScreenPreviewWrapper()
}
