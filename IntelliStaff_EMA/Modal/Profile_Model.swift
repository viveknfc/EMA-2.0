//
//  Profile_Model.swift
//  IntelliStaff_EMA
//
//  Created by ios on 13/08/25.
//

import Foundation

struct ProfileModel: Codable, Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
}
