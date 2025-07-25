//
//  Dashboard_Menu_Items.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 20/07/25.
//
import SwiftUI

struct Dashboard_Menu_Items: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let imageName: String  // system or asset image name
    let itemCount: Int
    let children: [ChildItem]?
}

struct MenuGroup {
    let parent: MenuItem
    let children: [MenuItem]
}

struct ChildItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let apiKey: String
}

