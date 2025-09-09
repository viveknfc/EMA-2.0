//
//  CurveConcavePreview.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 18/07/25.
//

import SwiftUI

    struct CurveConcavePreview: View {
        
       @State private var selection: Int = 0
       @State private var constant = ATConstant(axisMode: .bottom, screen: .init(activeSafeArea: false), tab: .init())
       @State private var radius: CGFloat = 66//96
        @State private var concaveDepth: CGFloat = 0.86//0.96
        @State private var color: Color = .theme//Color(hex: 0x1A4E56)

        @State private var showLogoutAlert = false
        @Environment(\.dismiss) private var dismiss
        @Binding var path: [AppRoute]
        
        @State private var selectedAssignment: Dashboard_Menu_Items? = nil

        @State var dashboardViewModel: DashboardViewModel
        @State private var showSheet = false
        
        @State private var profileVM = ProfileViewModel()
        
        @State private var showPrimaryAlert = false
        @State private var alertMessage = ""
        
        @State private var emptyDashboardAlert = false
       
       var body: some View {
           GeometryReader { proxy in
               ZStack {
                   AxisTabView(selection: $selection, constant: constant) { state in
                       ATCurveStyle(state, color: color, radius: radius, depth: concaveDepth)
                   } content: {
                       
                       ControlView(
                        selection: $selection,
                        constant: $constant,
                        radius: $radius,
                        concaveDepth: $concaveDepth,
                        color: $color,
                        tag: 0,
                        systemName: "house.fill",
                        safeArea: proxy.safeAreaInsets,
                        content: {
                            Dashboard_Screen(viewModel: dashboardViewModel, selectedAssignment: $selectedAssignment, showSheet: $showSheet, showAlert: $showPrimaryAlert,
                                alertMessage: $alertMessage)
                        }
                       )
                       
                       ControlView(
                        selection: $selection,
                        constant: $constant,
                        radius: $radius,
                        concaveDepth: $concaveDepth,
                        color: $color,
                        tag: 2,
                        systemName: "plus.circle.fill",
                        safeArea: proxy.safeAreaInsets,
                        content: {
                            Top_TabView(
                                path: $path,
                                candidateID: dashboardViewModel.candidateID,
                                ssn: dashboardViewModel.ssn,
                                clientId: dashboardViewModel.clientId,
                                lastName: dashboardViewModel.lastName
                            )
                        }
                       )
                       
                       ControlView(
                        selection: $selection,
                        constant: $constant,
                        radius: $radius,
                        concaveDepth: $concaveDepth,
                        color: $color,
                        tag: 4,
                        systemName: "person.fill",
                        safeArea: proxy.safeAreaInsets,
                        content: {
                            Profile_Screen(viewModal: profileVM, showLogoutAlert: $showLogoutAlert, path: $path)
                        }
                       )
                       
                   } onTapReceive: { selectionTap in
                       
                       if self.selection != selectionTap {
                           DispatchQueue.main.async {
                               let generator = UIImpactFeedbackGenerator(style: .medium)
                               generator.prepare()
                               generator.impactOccurred()
                           }
                       }
                       
                       /// Imperative syntax
                       print("---------------------")
                       print("Selection : ", selectionTap)
                       print("Already selected : ", self.selection == selectionTap)
                   }
                   
                   if selectedAssignment != nil {
                       Color.black.opacity(showSheet ? 0.4 : 0)
                           .ignoresSafeArea()
                           .onTapGesture {
                               withAnimation {
                                   showSheet = false
                               }
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                   selectedAssignment = nil
                               }
                           }

                       VStack {
                           Spacer()
                           ZStack {
                               Color(.systemBackground)

                               if let item = selectedAssignment {
                                   Children_BottomSheet_View(
                                       parentTitle: item.title,
                                       children: item.children ?? [],
                                       onDismiss: {
                                           withAnimation {
                                               showSheet = false
                                           }
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                               selectedAssignment = nil
                                           }
                                       }, path: $path
                                   )
                               }
                           }
                           .clipShape(RoundedCorner(radius: 40, corners: [.topLeft, .topRight]))
                           .frame(maxWidth: .infinity)
                           .frame(height: proxy.size.height * 0.5)
                           .opacity(showSheet ? 1 : 0)
                           .offset(y: showSheet ? 0 : proxy.size.height)
                           .animation(.easeInOut(duration: 0.3), value: showSheet)
                           .zIndex(1)
                       }
                       .ignoresSafeArea()
                   }

                   
                   if dashboardViewModel.isLoading {
                       Color.black.opacity(0.5)
                           .ignoresSafeArea()
                       TriangleLoader()
                   }
                   

               }
           }
           .onAppear {
               selectedAssignment = nil
               showSheet = false
           }
           .animation(.easeInOut, value: constant)
           .animation(.easeInOut, value: radius)
           .animation(.easeInOut, value: concaveDepth)
           .animation(.easeInOut(duration: 0.3), value: selectedAssignment)

           .navigationTitle("Tempositions")
           .navigationBarTitleDisplayMode(.inline)
           .navigationBarBackButtonHidden(true)
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button(action: {
                       print("Global right button tapped")
                       showLogoutAlert = true
                   }) {
                       Image(systemName: "rectangle.portrait.and.arrow.forward")
                           .font(.system(size: 14))
                           .foregroundColor(.white)
                   }
               }
           }
           
           .onChange(of: dashboardViewModel.showEmptyDashboardAlert) { _ , newValue in
               if newValue {
                   emptyDashboardAlert = true
                   dashboardViewModel.showEmptyDashboardAlert = false
               }
           }
           
           .overlay(
            Group {
                if showLogoutAlert {
                    AlertView(
                        image: Image(systemName: "exclamationmark.circle.fill"),
                        title: "Logout",
                        message: "Are you sure you want to logout?",
                        primaryButton: AlertButtonConfig(title: "OK", action: {
                            performLogout()
                        }),
                        secondaryButton: AlertButtonConfig(title: "Cancel", action: {}),
                        dismiss: {
                            showLogoutAlert = false
                        }
                    )
                    .transition(.opacity)
                }
                
                if showPrimaryAlert {
                    AlertView(
                        title: "Primary Device",
                        message: alertMessage,
                        primaryButton: AlertButtonConfig(title: "Yes", action: {
                            showPrimaryAlert = false
                            dashboardViewModel.updateLocationSharing1()
                        }),
                        secondaryButton: AlertButtonConfig(title: "No", action: {
                            showPrimaryAlert = false
                        }),
                        dismiss: {
                            showPrimaryAlert = false
                        }
                    )
                    .transition(.opacity)
                }
                
                if emptyDashboardAlert {
                    AlertView(
                        title: "Alert",
                        message: "No data available. please retry?",
                        primaryButton: AlertButtonConfig(title: "Retry", action: {
                            showPrimaryAlert = false
                            dashboardViewModel.fetchDashboard()
                        }),
                        dismiss: {
                            showLogoutAlert = false
                        }
                    )
                    .transition(.opacity)
                }
               }
           )
       }
        
        func performLogout() {
            UserDefaults.standard.removeObject(forKey: "isRemembered")
            UserDefaults.standard.removeObject(forKey: "savedUsername")
            UserDefaults.standard.removeObject(forKey: "savedPassword")
            path = [.login]
        }
        
}


#Preview {
    struct CurveConcavePreviewWrapper: View {
        @State private var path: [AppRoute] = []

        var body: some View {
            let sampleChildren = [
                ChildItem(name: "Algebra", imageName: "notes", apiKey: "link"),
                ChildItem(name: "Geometry", imageName: "notes", apiKey: "link"),
                ChildItem(name: "Trigonometry", imageName: "notes", apiKey: "link")
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

            return CurveConcavePreview(path: $path, dashboardViewModel: viewModel)
        }
    }

    return CurveConcavePreviewWrapper()
}


