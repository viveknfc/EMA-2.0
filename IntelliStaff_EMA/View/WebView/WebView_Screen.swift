//
//  WebView_Screen.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 24/07/25.
//

import SwiftUI

struct WebView_Screen: View {
    
    var urlKey: String
    @State private var isLoading = true
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var viewModel: DashboardViewModel
    let payload = buildWebViewPayload()
    
    var cleanedURLKey: String {
        var modified = urlKey
        if let range = modified.range(of: "&headless=true") {
            modified.removeSubrange(range)
        }
        return modified
    }
    
    var fullURL: URL {
        let base = APIConstants.baseURL
        let support = "EWA2"
        let combined =  "\(base)\(support)/\(cleanedURLKey)"

        return URL(string: combined) ?? URL(string: "https://example.com")!
    }
    
    var body: some View {

        ZStack {
            WebView(url: fullURL, isLoading: $isLoading, candidateData: viewModel.escapedCandidateJSONString ?? "", candidateInfo: viewModel.escapedDemographicsJSONString ?? "",currentUserJson: payload.currentUserJson, keyGuard: payload.keyGuard,     keyName: payload.keyName,
                accessToken: payload.accessToken,
                isHeadless: true)
            
            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                TriangleLoader()
            }
        }
        .onAppear {
            print("Full URL: \(fullURL)")
        }
        .navigationTitle("Tempositions")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward") // 👈 just the arrow
                        .foregroundColor(.white)
                        .imageScale(.large)
                }
            }
        }
        .tint(.white)
    }
}

#Preview {
    let mock = DashboardViewModel()
    mock.escapedCandidateJSONString = "{\"CandidateID\":123,\"Name\":\"Preview User\"}"

    return WebView_Screen(
        urlKey: "previewKey",
        viewModel: mock
    )
}

