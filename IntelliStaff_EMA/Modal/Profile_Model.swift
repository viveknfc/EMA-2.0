//
//  Profile_Model.swift
//  IntelliStaff_EMA
//
//  Created by ios on 13/08/25.
//

import Foundation
import SwiftUI

struct ProfileItem: Identifiable, Decodable {
    let id: Int
    let title: String
    let icon: String
}
