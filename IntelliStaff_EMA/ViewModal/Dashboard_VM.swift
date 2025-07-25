//
//  Dashboard_VM.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 21/07/25.
//

import Foundation

@MainActor
@Observable
class DashboardViewModel {
    var dashboardData: DashboardResponse?
    var menuGroups: [MenuGroup] = []
    var dashboardMenuItems: [Dashboard_Menu_Items] = []

    var isLoading = false
    var errorMessage: String?

    func fetchDashboard() {
        Task {
            isLoading = true
            do {
                guard let userId = UserDefaults.standard.value(forKey: "userId") as? Int else {
                    print("User ID not found or not an Int")
                    return
                }
                
                let params: [String: Any] = [
                    "candidateId": userId
                ]
                let result = try await APIFunction.dashboardAPICalling(params: params)

//                print("the result for dashbaord is ", result)
                
                self.dashboardData = result
                self.menuGroups = self.groupMenuItems(result.objMenuInformationList)
                self.dashboardMenuItems = self.menuGroups.map { group in
                    
                    let children: [ChildItem] = group.children.map {
                        ChildItem(name: $0.linkText, apiKey: $0.apiKey)
                    }
                    
                    return Dashboard_Menu_Items(
                        title: group.parent.linkText,
                        imageName: self.imageName(for: group.parent.linkText), // see helper
                        itemCount: group.children.count, children: children
                    )
                }
                self.isLoading = false
            } catch {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
            }
        }
    }
    
    // MARK: - Menu Grouping

    private func groupMenuItems(_ items: [MenuItem]) -> [MenuGroup] {
        let parents = items.filter { $0.parentMenuId == nil }
        return parents.map { parent in
            let children = items.filter { $0.parentMenuId == parent.id }
            return MenuGroup(parent: parent, children: children)
        }
    }
    
    // MARK: - Static icon mapping (can customize)
    private func imageName(for title: String) -> String {
        switch title {
        case "Dashboard": return "house"
        case "Payroll": return "banknote"
        case "Employee Benefits": return "heart.text.square"
        case "Manage Profile": return "person.crop.circle"
        default: return "square.grid.2x2"
        }
    }
}

