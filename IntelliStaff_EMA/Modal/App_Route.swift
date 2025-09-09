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
    case codeScreen(email: String)
    case newPassword(email: String)
    case dashboard
    case webView(apiKey: String)
    case settings
}

// AppRoute+ViewFactory.swift
extension AppRoute {
    @MainActor @ViewBuilder
    func destinationView(path: Binding<[AppRoute]>, dashboardViewModel: DashboardViewModel) -> some View {
        switch self {
        case .login:
            Login_Screen(path: path)
        case .forgotPassword:
            Forgot_Screen(path: path)
        case .codeScreen(let email):
            Code_Screen(path: path, email: email)
        case .newPassword(let email):
            NewPassword_Screen(path: path, email: email)
        case .dashboard:
            CurveConcavePreview(path: path, dashboardViewModel: dashboardViewModel)
        case .webView(let apiKey):
            WebView_Screen(urlKey: apiKey, viewModel: dashboardViewModel)
        case .settings:
            SettingsScreen(path: path)
        }
    }
}

