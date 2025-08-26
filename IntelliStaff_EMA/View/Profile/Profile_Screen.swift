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
