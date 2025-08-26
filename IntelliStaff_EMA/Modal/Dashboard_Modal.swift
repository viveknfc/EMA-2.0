import Foundation

// MARK: - Root
struct DashboardResponse: Codable {
    let objCandidatesModel: CandidateModel
    let objMenuInformationList: [MenuItem]
    let objCandidateAssignmentsWithDetails: [CandidateAssignment]

    enum CodingKeys: String, CodingKey {
        case objCandidatesModel = "objCandidatesModel"
        case objMenuInformationList = "objMenuInformationList"
        case objCandidateAssignmentsWithDetails = "objCandidateAssignmentsWithDetails"
    }
}

// MARK: - CandidateModel (Fixed)
struct CandidateModel: Codable {
    let candidateID: Int?
    let name: String?
    let lastName: String?
    let middleName: String?
    let firstName: String?
    let address: String?
    let city: String?
    let state: String?
    let zip: String?
    let homePhone: String?
    let cellPhone: String?
    let beep: String?
    let altPhone: String?
    let division: String?
    let candidateType: String?
    let email: String?
    let minimumPay: Double?
    let crime: Int?
    let ssn: String?
    let i9Compl: String?
    let unSkill: String?
    let eRating: Int?
    let divisionId: Int?
    let office: Int?
    let candidateTotalCount: Int?
    let employedSince: String?
    let dateEntered: String?
    let dateAvailable: String?
    let submitDateTime: String?
    let createdOn: String?
    let modifiedOn: String?
    let apt: String?
    let dnrChecked: Int?
    let fax: String?
    let rep: Int?
    let statusId: Int?
    let onBoardingStausId: Int?
    let subStatusId: Int?
    let userId: Int?
    let dnrDescription: String?
    let status: String?
    let subStatus: String?
    let onBoardingStaus: String?
    let isPermCandidate: Bool?
    let candidateTypeId: Int?
    let sourceId: Int?
    let personalRepId: Int?
    let notes: String?
    let fileName: String?
    let highSchool: String?
    let college: String?
    let postCollege1: String?
    let postCollege2: String?
    let businessOrOther: String?
    let dob: String?
    let recName: String?
    let perRep: String?
    let appSubmitDate: String?
    let referalCandidateId: Int?          // Changed from String? to Int?
    let referralCandidateName: String?
    let message: String?
    let webUserId: Int?                   // Changed from String? to Int?
    let actCreationDate: String?
    let passwdRecovered: String?
    let maxPay: Double?
    let posSeeking: String?
    let unempl: String?
    let unemplasof: String?
    let recruiterId: Int?                 // Changed from String? to Int?
    let scrSignatureDate: String?
    let scrSubmittalDate: String?         // Fixed CodingKey below
    let siteClearanceEligibleDate: String?
    let sexualHarassmentTrainingCompletionDate: String?
    let isIndependentContractor: Bool?
    let educationLevel: String?
    let isVendorCandidate: Bool?
    let clientId: Int?                    // Changed from String? to Int?
    let vendorReference: String?
    let contactId: Int?                   // Changed from String? to Int?
    let canScrId: String?
    let rcvIvr: String?
    let creAutoEmails: String?
    let sendTextMsgs: Bool?
    let pjbContactMethod: Int?
    let sfHcWaiver: String?
    let hot: String?
    let needUpdated: Int?
    let lastTimeslipWE: String?
    let fromast: String?
    let netProfit: Double?
    let i9Verified: String?
    let healthSup: String?
    let inEmpowermentZone: String?
    let noPaystub: Int?
    let directDep: Int?
    let independentContractor: Bool?
    let consumerReport: String?
    let isPhotoUploaded: Int?
    let pushNotifications: Int?
    let locationTracking: Int?
    let i9DocumentsUploaded: Int?
    let overAllReferencePosition: Int?
    let applicantId: String?
    let i9Dob: String?
    let agentId: String?
    let agentName: String?
    let onboardingSubStatusId: Int?       // Changed from String? to Int?
    let numberOfOrders: Int?
    let paymentType: String?
    let emergencyContactPhone: String?
    let emergencyContactName: String?
    let appType: String?
    let locationId: Int?                  // Changed from String? to Int?
    let password: String?
    let isClinical: Bool?
    let employeeRegistrationList: String?
    let payRate: String?
    let createdBy: Int?
    let queueFileId: String?
    let applicantResumeId: String?
    let isOnboardEmail: Int?
    let source: String?
    let user: String?

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
        case email = "EMail"
        case minimumPay = "MinimumPay"
        case crime = "Crime"
        case ssn = "SSN"
        case i9Compl = "I9Compl"
        case unSkill = "UnSkill"
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
        case fax = "Fax"
        case rep = "Rep"
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
        case scrSubmittalDate = "SCRsubmittaldate"  // Fixed: exact match to JSON
        case siteClearanceEligibleDate = "SiteClearanceEligibleDate"
        case sexualHarassmentTrainingCompletionDate = "SexualHarassmentTrainingCompletionDate"
        case isIndependentContractor = "IsIndependentContractor"
        case educationLevel = "EducationLevel"
        case isVendorCandidate = "IsVendorCandidate"
        case clientId = "ClientId"
        case vendorReference = "VendorReference"
        case contactId = "ContactId"
        case canScrId = "CanScrId"
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
        case independentContractor = "IndependentContractor"
        case consumerReport = "ConsumerReport"
        case isPhotoUploaded = "IsPhotoUploaded"
        case pushNotifications = "Pushnotifications"
        case locationTracking = "Locationtracking"
        case i9DocumentsUploaded = "I9DocumentsUploaded"
        case overAllReferencePosition = "OverAllReferencePosition"
        case applicantId = "ApplicantId"
        case i9Dob = "I9Dob"
        case agentId = "AgentId"
        case agentName = "AgentName"
        case onboardingSubStatusId = "OnboardingSubStatusId"
        case numberOfOrders = "NumberofOrders"
        case paymentType = "PaymentType"
        case emergencyContactPhone = "EmergencyContactPhone"
        case emergencyContactName = "EmergencyContactName"
        case appType = "AppType"
        case locationId = "LocationId"
        case password = "Password"
        case isClinical = "IsClinical"
        case employeeRegistrationList = "EmployeeRegistrationList"
        case payRate = "PayRate"
        case createdBy = "CreatedBy"
        case queueFileId = "QueueFileId"
        case applicantResumeId = "ApplicantResumeId"
        case isOnboardEmail = "IsOnboardEmail"
        case source = "source"
        case user = "User"
    }
}

// MARK: - MenuInformation
struct MenuItem: Codable {
    let menuId: Int?
    let parentMenuId: Int?
    let linkText: String?
    let controller: String?
    let action: String?
    let menuOrder: Int?
    let className: String?
    let apiKey: String?

    enum CodingKeys: String, CodingKey {
        case menuId = "MenuId"
        case parentMenuId = "ParentMenuId"
        case linkText = "LinkText"
        case controller = "Controller"
        case action = "Action"
        case menuOrder = "MenuOrder"
        case className = "ClassName"
        case apiKey = "APIKey"
    }
}

// MARK: - CandidateAssignment
struct CandidateAssignment: Codable {
    // Your fields for objCandidateAssignmentsWithDetails (empty in example)
}
