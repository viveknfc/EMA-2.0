//
//  Demographic_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 30/07/25.
//

struct CandidateInfo: Codable {
    let candidateId: Int
    let firstName: String
    let middleName: String
    let lastName: String
    let apartmentNumber: String
    let city: String
    let state: String
    let zipCode: String
    let email: String
    let ssn: String
    let dob: String?                   // nullable
    let permanentHomeAddress: String
    let divisionId: Int
    let skills: [Int]
    let divisionName: String
    let companyEmail: String
    let empSince: String?             // nullable
    let userdetails: UserDetails
    let maskedDOB: String
}

struct UserDetails: Codable {
    let name: String
    let phone: String
}

struct LoggedInInfo: Codable {
    let candidateId: Int
    let accessToken: String
    let applicantId: Int
    let companyEmail: String
    let division: Int
    let divisionName: String
    let email: String
    let firstName: String
    let id: Int
    let lastName: String
    let skills: [Int]
}

