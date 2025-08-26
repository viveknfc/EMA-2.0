//
//  profile_VM.swift
//  IntelliStaff_EMA
//
//  Created by ios on 13/08/25.
//

import Foundation

@MainActor
@Observable
class ProfileViewModel {

     var profileList: [ProfileModel] = []
     var isLoading: Bool = false
    var errorMessage: String?

    func fetchProfileData() {
        
        let apiTitles = ["View Messages", "Refer A Friend", "upload Credentials", "Upload Photo", "Update Employee Profile", "Change Password", "Your Reps Info", "Logout", "Settings"]
        
        self.profileList = apiTitles.map { title in ProfileModel(title: title, imageName: imageForTitle(title)) }
    }
    
    private func imageForTitle(_ title: String) -> String {
        switch title {
        case "View Messages":         return "envelope"
        case "Refer A Friend":        return "person.2.fill"
        case "upload Credentials":    return "doc.badge.plus"
        case "Upload Photo":          return "photo.on.rectangle"
        case "Update Employee Profile": return "person.crop.circle.badge.plus"
        case "Change Password":       return "key"
        case "Your Reps Info":        return "person.text.rectangle"
        case "Logout":                return "arrow.backward.circle"
        case "Settings":              return "gearshape"
        default:                      return "questionmark.circle"
        }
    }

}

