//
//  ETHistory_VM.swift
//  IntelliStaff_EMA
//
//  Created by NFC Solutions on 11/08/25.
//

import SwiftUI

@MainActor
@Observable
class HistoryViewModel {
     var historyData: [ETimeclockHistoryResponse] = []
     var isLoading = false
     var errorMessage: String?

    func fetchHistory(candidateID: Int, weekend: String) async {
        isLoading = true
        errorMessage = nil
        
        let params: [String: Any] = [
            "CandidateId": "\(candidateID)",
            "WeekendDate": weekend
        ]
        
        print("the params are:", params, terminator: "\n")
        
        do {
            let result = try await APIFunction.eTimeClockHistoryAPICalling(params: params)
            self.historyData = result
            print("History API Result:", result)
        } catch {
            self.errorMessage = error.localizedDescription
            print("History API Error:", error.localizedDescription)
        }
        
        isLoading = false
    }
}
