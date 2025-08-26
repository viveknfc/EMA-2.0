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
        case .codeScreen:
            Code_Screen(path: path)
        case .newPassword:
            NewPassword_Screen(path: path)
        case .dashboard:
            CurveConcavePreview(path: path, dashboardViewModel: dashboardViewModel)
        case .webView(let apiKey):
            WebView_Screen(urlKey: apiKey, viewModel: dashboardViewModel)
        case .settings:
            SettingsScreen(path: path)
        }
    }
}

