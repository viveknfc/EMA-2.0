//
//  Profile_Screen.swift
//  IntelliStaff_EMA
//
//  Created by ios on 13/08/25.
//

import SwiftUI

struct Profile_Screen: View {
    
    @State var viewModal: ProfileViewModel
    @Binding var showLogoutAlert: Bool
    @Binding var path: [AppRoute]
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(viewModal.profileList) { item in
                            Button {
                                print("row clicked: \(item.title)")
                                
                                if item.title == "View Messages" {
                                    path.append(.webView(apiKey: "ManageProfile/ViewMessages"))
                                }

                                if item.title == "Refer A Friend" {
                                    path.append(.webView(apiKey: "ReferAFriend/ReferAJob"))
                                }
                                
                                if item.title == "upload Credentials" {
                                    path.append(.webView(apiKey: "ManageProfile/UploadCredentials"))
                                }
                                
                                if item.title == "Upload Photo" {
                                    path.append(.webView(apiKey: "ManageProfile/UploadPhoto"))
                                }
                                
                                if item.title == "Update Employee Profile" {
                                    path.append(.webView(apiKey: "ManageProfile/UpdateEmployeeProfile"))
                                }
                                
                                if item.title == "Change Password" {
                                    path.append(.webView(apiKey: "ManageProfile/ChangePassword"))
                                }
                                
                                if item.title == "Your Reps Info" {
                                    path.append(.webView(apiKey: "ManageProfile/YourRepsInfo"))
                                }
                                
                                if item.title == "Logout" {
                                    showLogoutAlert = true
                                }

                                if item.title == "Settings" {
                                    path.append(.settings)
                                }
                            } label: {
                                Profile_Row(item: item)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .contentShape(Rectangle()) // ensures whole frame is tappable
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 0)
                }
                .onAppear {
                    viewModal.fetchProfileData()
                }
            }
        }
        
    }
}

#Preview {
    var vm = ProfileViewModel()
    vm.fetchProfileData() // so preview has sample rows
    return Profile_Screen(
        viewModal: vm,
        showLogoutAlert: .constant(false),
        path: .constant([])
    )
}
