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
    
    var escapedCandidateJSONString: String?
    var escapedDemographicsJSONString: String?
    
    var candidateID: Int?
    var ssn: String?
    var clientId: Int?
    var lastName: String?

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
//                print("the dashbaord result is ", result)
                
                await candidateIDAPI(candidateId: userId)
                await demographicAPI(candidateId: userId)
                
                print("candiate api finihsed calling")
                
                self.dashboardData = result
                
                if let firstName = result.objCandidatesModel.firstName {
                    UserDefaults.standard.set(firstName, forKey: "firstName")
                }
                
                self.menuGroups = self.groupMenuItems(result.objMenuInformationList)
                self.dashboardMenuItems = self.menuGroups.map { group in
                    
                    let children: [ChildItem] = group.children.map {
                        ChildItem(name: $0.linkText ?? "", imageName: "notes" , apiKey: $0.apiKey ?? "")
                    } //self.imageName(for: "Payroll")
                    
                    return Dashboard_Menu_Items(
                        title: group.parent.linkText ?? "",
                        imageName: self.imageName(for: group.parent.linkText ?? ""), // see helper
                        itemCount: group.children.count, children: children
                    )
                }
                self.isLoading = false
            } catch {
                    self.errorMessage = error.localizedDescription
                    print("the error for dashbaord fetching api is ", self.errorMessage ?? "")
                    self.isLoading = false
            }
        }
    }
    
    //MARK: - Candidate ID API Calling
    
    func candidateIDAPI(candidateId: Int) async {
        let params: [String: Any] = [
            "candidateId": candidateId
        ]
        do {
            let result = try await APIFunction.candidateIdAPICalling(params: params)
            
            self.candidateID = result.candidateID
            self.ssn = result.ssn
            self.clientId = result.clientId
            self.lastName = result.lastName
            
            // ✅ Encode to JSON string
            let encoder = JSONEncoder()
            let data = try encoder.encode(result)
            if let jsonString = String(data: data, encoding: .utf8) {
                let doubleEncoded = "\"\(jsonString)\"" // 👈 wraps JSON string in quotes
                let escapedCandidateJSON = escapeForJavaScript(doubleEncoded)
                self.escapedCandidateJSONString = escapedCandidateJSON

            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    //MARK: - Demographic API Calling
    
    func demographicAPI(candidateId: Int) async {
        let params: [String: Any] = [
            "candidateId": candidateId
        ]
        do {
            let result = try await APIFunction.demographicAPICalling(params: params)
//            print("the result for demographic API is ", result)
            let accessToken = APIConstants.accessToken
            
            let subset = LoggedInInfo(
                candidateId: result.candidateId,
                accessToken: accessToken,
                applicantId: result.candidateId,
                companyEmail: result.companyEmail,
                division: result.divisionId,
                divisionName: result.divisionName,
                email: result.email,
                firstName: result.firstName,
                id: result.candidateId,
                lastName: result.lastName,
                skills: result.skills
            )
            
            
            // ✅ Encode to JSON string
            let encoder = JSONEncoder()
            let data = try encoder.encode(subset)
            if let jsonString = String(data: data, encoding: .utf8) {
                let doubleEncoded = "\"\(jsonString)\"" // 👈 wraps JSON string in quotes
                let escaped = escapeForJavaScript(doubleEncoded)
                self.escapedDemographicsJSONString = escaped

            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Menu Grouping

    private func groupMenuItems(_ items: [MenuItem]) -> [MenuGroup] {
        let parents = items.filter { $0.parentMenuId == nil }
        return parents.map { parent in
            let children = items.filter { $0.parentMenuId == parent.menuId }
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

