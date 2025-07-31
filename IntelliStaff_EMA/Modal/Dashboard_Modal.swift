//
//  Dashboard_Modal.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 20/07/25.
//

struct DashboardResponse: Codable {
    let objCandidatesModel: CandidateModel
    let objMenuInformationList: [MenuItem]
    let objCandidateAssignmentsWithDetails: [CandidateAssignment]
}

struct CandidateModel: Codable {
    let candidateID: Int?
    let firstName: String?
    let lastName: String?
    let eMail: String?
    let dob: String?
    let homePhone: String?
    let cellPhone: String?
    let address: String?
    let city: String?
    let state: String?
    let zip: String?
    let emergencyContactName: String?
    let emergencyContactPhone: String?
    let createdOn: String?
    let appSubmitDate: String?
    let i9Dob: String?
    let perRep: String?
    let status: String?
    let subStatus: String?
    let onBoardingStaus: String?
    // Add the rest as needed

    enum CodingKeys: String, CodingKey {
        case candidateID = "CandidateID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case eMail = "EMail"
        case dob = "Dob"
        case homePhone = "HomePhone"
        case cellPhone = "CellPhone"
        case address = "Address"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case emergencyContactName = "EmergencyContactName"
        case emergencyContactPhone = "EmergencyContactPhone"
        case createdOn = "CreatedOn"
        case appSubmitDate = "AppSubmitDate"
        case i9Dob = "I9Dob"
        case perRep = "PerRep"
        case status = "Status"
        case subStatus = "SubStatus"
        case onBoardingStaus = "OnBoardingStaus"
    }
}

struct MenuItem: Codable, Hashable {
    let id: Int
    let linkText: String
    let apiKey: String
    let controller: String?
    let className: String?
    let action: String?
    let menuOrder: Int
    let parentMenuId: Int?

    enum CodingKeys: String, CodingKey {
        case id = "MenuId"
        case linkText = "LinkText"
        case apiKey = "APIKey"
        case controller = "Controller"
        case className = "ClassName"
        case action = "Action"
        case menuOrder = "MenuOrder"
        case parentMenuId = "ParentMenuId"
    }
}

struct CandidateAssignment: Codable {
    // Define fields when data is available
}

