//
//  App_ROute.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 20/07/25.
//

import SwiftUICore

enum AppRoute: Hashable {
    case login
    case forgotPassword
    case codeScreen
    case newPassword
    case dashboard
    case webView(apiKey: String)
}

// AppRoute+ViewFactory.swift
extension AppRoute {
    @MainActor @ViewBuilder
    func destinationView(path: Binding<[AppRoute]>) -> some View {
        switch self {
        case .login:
            Login_Screen(path: path)
        case .forgotPassword:
            Forgot_Screen(path: path)
        case .codeScreen:
            Code_Screen(path: path)
        case .newPassword:
            NewPassword_Screen(path: path)
        case .dashboard:
            CurveConcavePreview(path: path, dashboardViewModel: DashboardViewModel())
        case .webView(let apiKey):
            WebView_Screen(urlKey: apiKey)
        }
    }
}

