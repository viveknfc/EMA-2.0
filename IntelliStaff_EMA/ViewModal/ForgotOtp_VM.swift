//
//  ForgotOtp_VM.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 09/09/25.
//

import Foundation

@MainActor
@Observable
class ForgotOtpViewModel {
    
    var isLoading = false
    var errorMessage: String?
    var forgotResponse: ForgotOtpResponse?
    var isOtpSuccess = false
    
    func forgotOtp(email: String, errorHandler: GlobalErrorHandler) async -> ForgotOtpResponse? {
        isLoading = true
        defer { isLoading = false }
        
        let params: [String: Any] = ["requestsource": 4,
                                     "username": email,
                                     "usertype": 2]
        
        print("the Forgot otp params is", params)
        
        do {
            let response = try await APIFunction.forgotOtpAPICalling(params: params)
            print("the response for forgot otp is", response)
            forgotResponse = response
            return response
        }
        catch let error as NetworkError {
            self.errorMessage = error.localizedDescription
            errorHandler.handleNetworkError(error)
            return nil
        } catch {
            self.errorMessage = error.localizedDescription
            errorHandler.showError(message: error.localizedDescription, mode: .alert)
            return nil
        }
    }
}
