//
//  profile_VM.swift
//  IntelliStaff_EMA
//
//  Created by ios on 13/08/25.
//

import Foundation
import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var profileItems: [ProfileItem] = []
    @Published var isLoading: Bool = true

    func fetchProfileData() async {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

        // Simulated API response
        self.name = "John Doe"
        self.email = "johndoe@example.com"
        self.profileItems = [
            ProfileItem(id: 1, title: "Employee Profile", icon: "person.circle"),
            ProfileItem(id: 2, title: "Change Password", icon: "key"),
            ProfileItem(id: 3, title: "Settings", icon: "gear"),
            ProfileItem(id: 4, title: "Logout", icon: "rectangle.portrait.and.arrow.right")
        ]
        self.isLoading = false
    }
}

