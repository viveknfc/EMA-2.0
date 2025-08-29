//
//  Demographic_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 30/07/25.
//

struct CandidateInfo: Codable {
    let candidateId: Int
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let apartmentNumber: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let email: String?
    let ssn: String?
    let dob: String?
    let permanentHomeAddress: String?
    let divisionId: Int?
    let skills: [Int]?
    let divisionName: String?
    let companyEmail: String?
    let empSince: String?
    let userdetails: UserDetails?
    let candidateType: Int?
    let maskedDOB: String?

    enum CodingKeys: String, CodingKey {
        case candidateId, firstName, middleName, lastName,
             apartmentNumber, city, state, zipCode, email, ssn,
             dob, permanentHomeAddress, divisionId, skills,
             divisionName, companyEmail, empSince, userdetails,
             candidateType, maskedDOB
    }
}

struct UserDetails: Codable {
    let name: String?
    let phone: String?
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

