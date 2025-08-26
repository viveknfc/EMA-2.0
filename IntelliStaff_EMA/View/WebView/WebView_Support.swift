//
//  WebView_Support.swift
//  IntelliStaff_EMA
//
//  Created by Vivek Lakshmanan on 24/07/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    
    let candidateData: String
    let candidateInfo: String
    let currentUserJson: String
    let keyGuard: String
    let keyName: String
    let accessToken: String
    let isHeadless: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        config.websiteDataStore = .default()
        
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }


    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url != url {
            print("✅ WebView is loading: \(url.absoluteString)")
            uiView.load(URLRequest(url: url))
        }
    }
    

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            let trimmed = parent.candidateData.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            let escapedForJS = trimmed
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
            
            let trimmed1 = parent.currentUserJson.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            let escapedForJS1 = trimmed1
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
            
            let trimmed2 = parent.candidateInfo.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
            let escapedForJS2 = trimmed2
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")

            let js = """

             const candidateData = JSON.parse("\(escapedForJS)");
             localStorage.setItem("candidateData", JSON.stringify(candidateData));
            
             const candidateData1 = JSON.parse("\(escapedForJS1)");
             localStorage.setItem("currentUserEWA", JSON.stringify(candidateData1));
            
             const candidateData2 = JSON.parse("\(escapedForJS2)");
             sessionStorage.setItem("loggedinInfo", JSON.stringify(candidateData2));

             localStorage.setItem("accessToken", candidateData1.accessToken);

              localStorage.setItem("keygaurd", "\(parent.keyGuard)");
              localStorage.setItem("keyname", "\(parent.keyName)");
              localStorage.setItem("isHeadless", "true");
             
            """

//            print("Injected JS: \(js)")

            webView.evaluateJavaScript(js) { result, error in
                if let error = error {
                    print("❌ JS injection error: \(error.localizedDescription)")
                } else {
                    print("✅ JavaScript injected successfully")
                }
            }
        }

    }
}

