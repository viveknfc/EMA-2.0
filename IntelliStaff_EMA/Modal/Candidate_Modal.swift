//
//  Candidate_Modal.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 28/07/25.
//

import Foundation

struct CandidateIdModel: Codable {
    let candidateID: Int?
    let name, lastName, middleName, firstName: String?
    let address, city, state, zip: String?
    let homePhone, cellPhone, beep, altPhone: String?
    let division, candidateType, eMail, ssn: String?
    let i9Compl, unSkill: String?
    let minimumPay: Double?
    let crime, eRating, divisionId, office: Int?
    let candidateTotalCount: Int?
    let employedSince, dateEntered, dateAvailable, submitDateTime: String?
    let createdOn, modifiedOn: String?
    let apt: String?
    let dnrChecked, rep: Int?
    let fax: String?
    let statusId, onBoardingStausId, subStatusId, userId: Int?
    let dnrDescription, status, subStatus, onBoardingStaus: String?
    let isPermCandidate: Int?
    let candidateTypeId, sourceId, personalRepId: Int?
    let notes, fileName, highSchool, college: String?
    let postCollege1, postCollege2, businessOrOther: String?
    let dob, recName, perRep, appSubmitDate: String?
    let referalCandidateId: Int?
    let referralCandidateName, message: String?
    let webUserId: Int?
    let actCreationDate, passwdRecovered: String?
    let maxPay: Double?
    let posSeeking: String?
    let unempl: Int?
    let unemplasof: String?
    let recruiterId: Int?
    let scrSignatureDate, scrsubmittaldate, siteClearanceEligibleDate: String?
    let sexualHarassmentTrainingCompletionDate: String?
    let isIndependentContractor: Int?
    let educationLevel: String?
    let isVendorCandidate: Int?
    let clientId, contactId, canScrId: Int?
    let vendorReference: String?
    let rcvIvr, creAutoEmails, sendTextMsgs: Bool?
    let pjbContactMethod: Int?
    let sfHcWaiver: Int?
    let hot: Int?
    let needUpdated: Int?
    let lastTimeslipWE, fromast: String?
    let netProfit: Double?
    let i9Verified, healthSup: Int?
    let inEmpowermentZone: Int?
    let noPaystub, directDep, isPhotoUploaded, pushnotifications, locationtracking, i9DocumentsUploaded, overAllReferencePosition: Int?
    let independentContractor: Bool?
    let consumerReport: String?
    let applicantId: Int?
    let i9Dob: String?
    let agentId: String?
    let agentName: String?
    let onboardingSubStatusId, numberofOrders: Int?
    let paymentType, emergencyContactPhone, emergencyContactName: String?
    let appType: String?
    let locationId, createdBy, queueFileId, isOnboardEmail: Int?
    let password: String?
    let isClinical: Bool?
    let employeeRegistrationList: String?
    let payRate: Double?
    let applicantResumeId, source, user: String?
    
    enum CodingKeys: String, CodingKey {
        case candidateID = "CandidateID"
        case name = "Name"
        case lastName = "LastName"
        case middleName = "MiddleName"
        case firstName = "FirstName"
        case address = "Address"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case homePhone = "HomePhone"
        case cellPhone = "CellPhone"
        case beep = "Beep"
        case altPhone = "AltPhone"
        case division = "Division"
        case candidateType = "CandidateType"
        case eMail = "EMail"
        case ssn = "SSN"
        case i9Compl = "I9Compl"
        case unSkill = "UnSkill"
        case minimumPay = "MinimumPay"
        case crime = "Crime"
        case eRating = "ERating"
        case divisionId = "DivisionId"
        case office = "Office"
        case candidateTotalCount = "CandidateTotalCount"
        case employedSince = "EmployedSince"
        case dateEntered = "DateEntered"
        case dateAvailable = "DateAvailable"
        case submitDateTime = "SubmitDateTime"
        case createdOn = "CreatedOn"
        case modifiedOn = "ModifiedOn"
        case apt = "Apt"
        case dnrChecked = "DnrChecked"
        case rep = "Rep"
        case fax = "Fax"
        case statusId = "StatusId"
        case onBoardingStausId = "OnBoardingStausId"
        case subStatusId = "SubStatusId"
        case userId = "UserId"
        case dnrDescription = "DnrDescription"
        case status = "Status"
        case subStatus = "SubStatus"
        case onBoardingStaus = "OnBoardingStaus"
        case isPermCandidate = "IsPermCandidate"
        case candidateTypeId = "CandidateTypeId"
        case sourceId = "SourceId"
        case personalRepId = "PersonalRepId"
        case notes = "Notes"
        case fileName = "FileName"
        case highSchool = "HighSchool"
        case college = "College"
        case postCollege1 = "PostCollege1"
        case postCollege2 = "PostCollege2"
        case businessOrOther = "BusinessOrOther"
        case dob = "Dob"
        case recName = "RecName"
        case perRep = "PerRep"
        case appSubmitDate = "AppSubmitDate"
        case referalCandidateId = "ReferalCandidateId"
        case referralCandidateName = "ReferralCandidateName"
        case message = "Message"
        case webUserId = "WebUserId"
        case actCreationDate = "ActCreationDate"
        case passwdRecovered = "PasswdRecovered"
        case maxPay = "MaxPay"
        case posSeeking = "PosSeeking"
        case unempl = "Unempl"
        case unemplasof = "Unemplasof"
        case recruiterId = "RecruiterId"
        case scrSignatureDate = "ScrSignatureDate"
        case scrsubmittaldate = "Scrsubmittaldate"
        case siteClearanceEligibleDate = "SiteClearanceEligibleDate"
        case sexualHarassmentTrainingCompletionDate = "SexualHarassmentTrainingCompletionDate"
        case isIndependentContractor = "IsIndependentContractor"
        case educationLevel = "EducationLevel"
        case isVendorCandidate = "IsVendorCandidate"
        case clientId = "ClientId"
        case contactId = "ContactId"
        case canScrId = "CanScrId"
        case vendorReference = "VendorReference"
        case rcvIvr = "RcvIvr"
        case creAutoEmails = "CreAutoEmails"
        case sendTextMsgs = "SendTextMsgs"
        case pjbContactMethod = "PjbContactMethod"
        case sfHcWaiver = "SfHcWaiver"
        case hot = "Hot"
        case needUpdated = "NeedUpdated"
        case lastTimeslipWE = "LastTimeslipWE"
        case fromast = "Fromast"
        case netProfit = "NetProfit"
        case i9Verified = "I9Verified"
        case healthSup = "HealthSup"
        case inEmpowermentZone = "InEmpowermentZone"
        case noPaystub = "NoPaystub"
        case directDep = "DirectDep"
        case isPhotoUploaded = "IsPhotoUploaded"
        case pushnotifications = "Pushnotifications"
        case locationtracking = "Locationtracking"
        case i9DocumentsUploaded = "I9DocumentsUploaded"
        case overAllReferencePosition = "OverAllReferencePosition"
        case independentContractor = "IndependentContractor"
        case consumerReport = "ConsumerReport"
        case applicantId = "ApplicantId"
        case i9Dob = "I9Dob"
        case agentId = "AgentId"
        case agentName = "AgentName"
        case onboardingSubStatusId = "OnboardingSubStatusId"
        case numberofOrders = "NumberofOrders"
        case paymentType = "PaymentType"
        case emergencyContactPhone = "EmergencyContactPhone"
        case emergencyContactName = "EmergencyContactName"
        case appType = "AppType"
        case locationId = "LocationId"
        case createdBy = "CreatedBy"
        case queueFileId = "QueueFileId"
        case isOnboardEmail = "IsOnboardEmail"
        case password = "Password"
        case isClinical = "IsClinical"
        case employeeRegistrationList = "EmployeeRegistrationList"
        case payRate = "PayRate"
        case applicantResumeId = "ApplicantResumeId"
        case source = "Source"
        case user = "User"
    }
}



