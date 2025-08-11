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
     var historyData: [ETimeclock_History_Modal] = []
     var isLoading = false
     var errorMessage: String?

    func fetchHistory(candidateID: Int, clientId: Int, lastName: String, ssn: String, weekend: Date) async {
        isLoading = true
        errorMessage = nil
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let params: [String: Any] = [
            "CandidateId": candidateID,
            "ClientId": clientId,
            "DateMode": "weekend",
            "LastName": lastName,
            "SSN": ssn,
            "Source": "StandAlone",
            "Weekend": formatter.string(from: weekend)
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
