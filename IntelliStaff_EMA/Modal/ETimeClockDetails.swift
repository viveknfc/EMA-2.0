import Foundation

import Foundation

// MARK: - GetETCDetailsResponse
struct GetETCDetailsResponse: Codable {
    let activeOrder: Int
    let address: String?
    let candidateId: Int
    let clientId: Int?
    let companyName: String?
    let currentDate: String
    let deviceId: String?
    let etcCheck: Int
    let isLogOut: Int?
    let isLogin: Int?
    let isLunchOut: Int?
    let isMultipleLunch: Int?
    let isLunchIn: Int?
    let jobDescription: String?
    let logOut: String?
    let logIn: String?
    let logInDate: String?
    let log_out: String?
    let login: String?
    let lstETimeClockCandOrders: [ETimeClockOrderListModel]?
    let lstEtimeclockGetClients: [LstEtimeclockGetClientsModel]?
    let lunchIn: String?
    let lunchIn1: String?
    let lunchIn2: String?
    let lunchOut: String?
    let lunchOut1: String?
    let lunchOut2: String?
    let lunch_in: String?
    let lunch_in2: String?
    let lunch_out: String?
    let lunch_out2: String?
    let message: String?
    let minutesStepCount: Int?
    let mode: String?
    let myProperty: Int?
    let orderId: Int?
    let position: String?
    let positionCheck: Int?
    let positionID: Int?
    let retry: Int
    let showLunchButtons: Int?
    let showMealReturn: Int?
    let sleep: Int
    let status: String?
    let successStatus: Int?
    let timeId: Int?
    let type: String?
    let weekEnd: String?
    let workingDate: String?
    let enteredDate: String?
    let isETCcheck: Int?
    let latitude: String?
    let longitude: String?
    let order_id: Int?
    let showLunchPopup: Int?
    let showLunchPopupNew: Int?
    let showNoLunchButton: Int?
    let showNoLunchButtonNew: Int?

    enum CodingKeys: String, CodingKey {
        case activeOrder = "ActiveOrder"
        case address = "Address"
        case candidateId = "CandidateId"
        case clientId = "ClientId"
        case companyName = "CompanyName"
        case currentDate = "CurrentDate"
        case deviceId = "DeviceId"
        case etcCheck = "ETCcheck"
        case isLogOut = "IsLogOut"
        case isLogin = "IsLogin"
        case isLunchOut = "IsLunchOut"
        case isMultipleLunch = "IsMultipleLunch"
        case isLunchIn = "IslunchIn"
        case jobDescription = "Job_Description"
        case logOut = "LogOut"
        case logIn = "Log_in"
        case logInDate = "Log_inDate"
        case log_out = "Log_out"
        case login = "Login"
        case lstETimeClockCandOrders = "LstETimeClockCandOrders"
        case lstEtimeclockGetClients = "LstEtimeclockGetClients"
        case lunchIn = "LunchIn"
        case lunchIn1 = "LunchIn1"
        case lunchIn2 = "LunchIn2"
        case lunchOut = "LunchOut"
        case lunchOut1 = "LunchOut1"
        case lunchOut2 = "LunchOut2"
        case lunch_in = "Lunch_in"
        case lunch_in2 = "Lunch_in2"
        case lunch_out = "Lunch_out"
        case lunch_out2 = "Lunch_out2"
        case message = "Message"
        case minutesStepCount = "MinutesStepCount"
        case mode = "Mode"
        case myProperty = "MyProperty"
        case orderId = "OrderId"
        case position = "Position"
        case positionCheck = "PositionCheck"
        case positionID = "PositionID"
        case retry = "Retry"
        case showLunchButtons = "ShowLunchButtons"
        case showMealReturn = "ShowMealReturn"
        case sleep = "Sleep"
        case status = "Status"
        case successStatus = "SuccessStatus"
        case timeId = "TimeId"
        case type = "Type"
        case weekEnd = "WeekEnd"
        case workingDate = "WorkingDate"
        case enteredDate = "entereddate"
        case isETCcheck = "isETCcheck"
        case latitude = "latitude"
        case longitude = "longitude"
        case order_id = "order_id"
        case showLunchPopup = "showLunchPopup"
        case showLunchPopupNew = "showLunchPopupNew"
        case showNoLunchButton = "showNoLunchButton"
        case showNoLunchButtonNew = "showNoLunchButtonNew"
    }
}

// MARK: - LstEtimeclockGetClientsModel
struct LstEtimeclockGetClientsModel: Codable {
    let clientId: String?
    let address: String?
    let suite: String?
    let city: String?
    let state: String?
    let codeZip: String?
    let positionType: String?
    let positionId: String?

    enum CodingKeys: String, CodingKey {
        case clientId = "ClientId"
        case address = "Address"
        case suite = "Suite"
        case city = "City"
        case state = "State"
        case codeZip = "CodeZip"
        case positionType = "PositionType"
        case positionId = "PositionId"
    }
}

// MARK: - ETimeClockOrderListModel
struct ETimeClockOrderListModel: Codable {
    let clientId: Int?
    let companyName: String?
    let orderId: Int?
    let isMultipleLunch: Int?
    let jobDescription: String?
    let orderSchedule: String?
    let position: String?
    let type: String?
    let isETCcheck: Int?

    enum CodingKeys: String, CodingKey {
        case clientId = "Client_id"
        case companyName = "Company_name"
        case orderId = "Order_id"
        case isMultipleLunch = "IsMultipleLunch"
        case jobDescription = "Job_Description"
        case orderSchedule = "OrderSchedule"
        case position = "position"
        case type = "Type"
        case isETCcheck = "isETCcheck"
    }
}

