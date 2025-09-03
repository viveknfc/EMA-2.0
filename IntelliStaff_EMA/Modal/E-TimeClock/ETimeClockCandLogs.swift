import Foundation

struct ETimeClockResponse: Codable {
    let showLunchPopup: Int
    let showNoLunchButton: Int
    let showLunchPopupNew: Int
    let showNoLunchButtonNew: Int
    let address: String?
    let login: String?
    let logOut: String?
    let lunchOut: String?
    let lunchIn: String?
    let lunchOut1: String?
    let lunchIn1: String?
    let lunchOut2: String?
    let lunchIn2: String?
    let mode: String?
    let enteredDate: String?
    let lstETimeClockCandOrders: String? // keep optional
    let logInDate: String?
    let etcCheck: Int?                     // optional
    let candidateId: Int
    let timeId: Int
    let workingDate: String?
    let logIn: String?
    let logOutTime: String?
    let lunchInTime: String?
    let lunchOutTime: String?
    let lunchIn2Time: String?              // optional
    let lunchOut2Time: String?             // optional
    let weekEnd: String?
    let orderId: Int
    let type: String?
    let message: String?
    let status: String?
    let latitude: String?
    let longitude: String?
    let activeOrder: Int
    let clientId: Int
    let positionID: Int
    let lstEtimeclockGetClients: String?
    let position: String?
    let jobDescription: String?
    let companyName: String?
    let positionCheck: Int
    let myProperty: Int
    let minutesStepCount: Int
    let showLunchButtons: Int
    let showMealReturn: Int
    let isMultipleLunch: Int
    let isETCcheck: Int?                   // optional
    let currentDate: String?
    let order_id: Int
    let successStatus: Int
    let retry: Int
    let sleep: Int
    let isLogin: Int?                       // optional
    let isLogOut: Int?                      // optional
    let isLunchOut: Int?                    // optional
    let isLunchIn: Int?                     // optional
    let deviceId: String?

    enum CodingKeys: String, CodingKey {
        case showLunchPopup, showNoLunchButton, showLunchPopupNew, showNoLunchButtonNew
        case address = "Address"
        case login = "Login"
        case logOut = "LogOut"
        case lunchOut = "LunchOut"
        case lunchIn = "LunchIn"
        case lunchOut1 = "LunchOut1"
        case lunchIn1 = "LunchIn1"
        case lunchOut2 = "LunchOut2"
        case lunchIn2 = "LunchIn2"
        case mode = "Mode"
        case enteredDate = "entereddate"
        case lstETimeClockCandOrders = "LstETimeClockCandOrders"
        case logInDate = "Log_inDate"
        case etcCheck = "ETCcheck"
        case candidateId = "CandidateId"
        case timeId = "TimeId"
        case workingDate = "WorkingDate"
        case logIn = "Log_in"
        case logOutTime = "Log_out"
        case lunchInTime = "LunchInTime"
        case lunchOutTime = "LunchOutTime"
        case lunchIn2Time = "LunchInTime2"
        case lunchOut2Time = "LunchOutTime2"
        case weekEnd = "WeekEnd"
        case orderId = "OrderId"
        case type = "Type"
        case message = "Message"
        case status = "Status"
        case latitude, longitude
        case activeOrder = "ActiveOrder"
        case clientId = "ClientId"
        case positionID = "PositionID"
        case lstEtimeclockGetClients = "LstEtimeclockGetClients"
        case position = "Position"
        case jobDescription = "Job_Description"
        case companyName = "CompanyName"
        case positionCheck = "PositionCheck"
        case myProperty = "MyProperty"
        case minutesStepCount = "MinutesStepCount"
        case showLunchButtons = "ShowLunchButtons"
        case showMealReturn = "ShowMealReturn"
        case isMultipleLunch = "IsMultipleLunch"
        case isETCcheck = "isETCcheck"
        case currentDate = "CurrentDate"
        case order_id = "order_id"
        case successStatus = "SuccessStatus"
        case retry = "Retry"
        case sleep = "Sleep"
        case isLogin = "IsLogin"
        case isLogOut = "IsLogOut"
        case isLunchOut = "IsLunchOut"
        case isLunchIn = "IslunchIn"
        case deviceId = "DeviceId"
    }
}


