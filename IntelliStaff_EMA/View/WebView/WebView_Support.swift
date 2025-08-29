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
    var onTitleChange: ((String) -> Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true

        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        config.websiteDataStore = .default()
        
        // Inject JavaScript as early as possible using user script
        let userScript = WKUserScript(
            source: context.coordinator.createJavaScript(),
            injectionTime: .atDocumentStart,
            forMainFrameOnly: false
        )
        config.userContentController.addUserScript(userScript)
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.url != url {
            print("✅ WebView is loading: \(url.absoluteString)")
            let request = URLRequest(
                url: url,
                cachePolicy: .reloadIgnoringLocalCacheData,
                timeoutInterval: 30
            )
            uiView.load(request)
        }
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        private var hasInjectedForCurrentPage = false
        private var currentPageURL: String = ""

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
            hasInjectedForCurrentPage = false
            print("🚀 Started loading: \(webView.url?.absoluteString ?? "unknown")")
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            hasInjectedForCurrentPage = false
            print("❌ Navigation failed: \(error.localizedDescription)")
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
            hasInjectedForCurrentPage = false
            print("❌ Provisional navigation failed: \(error.localizedDescription)")
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            let newURL = webView.url?.absoluteString ?? ""
            if newURL != currentPageURL {
                currentPageURL = newURL
                hasInjectedForCurrentPage = false
                print("📄 Page committed: \(newURL)")
                
                // Inject as soon as DOM is available
                injectJavaScriptIfNeeded(into: webView)
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            parent.onTitleChange?(webView.title ?? "Untitled")
            print("✅ Page finished loading: \(webView.url?.absoluteString ?? "unknown")")
            
            // Final fallback injection
            injectJavaScriptIfNeeded(into: webView)
        }
        
        func createJavaScript() -> String {
            // Pre-process all data once and handle empty values
            let processedCandidateData = parent.candidateData.isEmpty ? "{}" : escapeForJavaScript(parent.candidateData)
            let processedCurrentUserJson = parent.currentUserJson.isEmpty ? "{}" : escapeForJavaScript(parent.currentUserJson)
            let processedCandidateInfo = parent.candidateInfo.isEmpty ? "{}" : escapeForJavaScript(parent.candidateInfo)
            let processedKeyGuard = escapeForJavaScript(parent.keyGuard)
            let processedKeyName = escapeForJavaScript(parent.keyName)
            let processedAccessToken = escapeForJavaScript(parent.accessToken)
            let isHeadlessStr = parent.isHeadless ? "true" : "false"
            
            return """
            (function() {
                // Prevent duplicate injections
                if (window.candidateDataInjected) {
                    console.log('📝 Candidate data already injected, skipping...');
                    return;
                }
                
                function injectCandidateData() {
                    try {
                        console.log('🚀 Starting candidate data injection...');
                        
                        // Parse and store candidate data (handle empty case)
                        const candidateDataStr = "\(processedCandidateData)";
                        if (candidateDataStr && candidateDataStr.trim() !== "") {
                            const candidateData = JSON.parse(candidateDataStr);
                            localStorage.setItem("candidateData", JSON.stringify(candidateData));
                            console.log('✅ candidateData stored');
                        } else {
                            console.log('⚠️ candidateData is empty, skipping...');
                        }
                        
                        // Parse and store current user data
                        const currentUserStr = "\(processedCurrentUserJson)";
                        if (currentUserStr && currentUserStr.trim() !== "") {
                            const currentUserData = JSON.parse(currentUserStr);
                            localStorage.setItem("currentUserEWA", JSON.stringify(currentUserData));
                            console.log('✅ currentUserEWA stored');
                            
                            // Use accessToken from currentUser if available
                            if (currentUserData.accessToken) {
                                localStorage.setItem("accessToken", currentUserData.accessToken);
                            } else {
                                localStorage.setItem("accessToken", "\(processedAccessToken)");
                            }
                        } else {
                            // Fallback to provided accessToken
                            localStorage.setItem("accessToken", "\(processedAccessToken)");
                            console.log('⚠️ currentUserData is empty, using fallback accessToken');
                        }
                        
                        // Parse and store candidate info (handle empty case)
                        const candidateInfoStr = "\(processedCandidateInfo)";
                        if (candidateInfoStr && candidateInfoStr.trim() !== "") {
                            const candidateInfo = JSON.parse(candidateInfoStr);
                            sessionStorage.setItem("loggedinInfo", JSON.stringify(candidateInfo));
                            console.log('✅ loggedinInfo stored');
                        } else {
                            console.log('⚠️ candidateInfo is empty, skipping...');
                        }
                        
                        // Store additional data (these should always be available)
                        localStorage.setItem("keygaurd", "\(processedKeyGuard)");
                        localStorage.setItem("keyname", "\(processedKeyName)");
                        localStorage.setItem("isHeadless", "\(isHeadlessStr)");
                        
                        // Mark as injected
                        window.candidateDataInjected = true;
                        
                        console.log('✅ All candidate data injection completed');
                        
                        // Dispatch custom event for web app
                        window.dispatchEvent(new CustomEvent('candidateDataReady', {
                            detail: { 
                                timestamp: Date.now(),
                                injectedItems: ['candidateData', 'currentUserEWA', 'loggedinInfo', 'accessToken', 'keygaurd', 'keyname', 'isHeadless'],
                                hasValidData: {
                                    candidateData: candidateDataStr && candidateDataStr.trim() !== "",
                                    currentUserData: currentUserStr && currentUserStr.trim() !== "",
                                    candidateInfo: candidateInfoStr && candidateInfoStr.trim() !== ""
                                }
                            }
                        }));
                        
                    } catch (error) {
                        console.error('❌ Candidate data injection failed:', error);
                        console.error('Error details:', {
                            candidateData: "\(processedCandidateData)".substring(0, 50) + "...",
                            currentUserJson: "\(processedCurrentUserJson)".substring(0, 50) + "...",
                            candidateInfo: "\(processedCandidateInfo)".substring(0, 50) + "..."
                        });
                        // Clear the flag so we can retry
                        window.candidateDataInjected = false;
                    }
                }
                
                // Execute based on document ready state
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', injectCandidateData);
                } else {
                    // DOM is already loaded, inject immediately
                    injectCandidateData();
                }
            })();
            """
        }
        
        private func injectJavaScriptIfNeeded(into webView: WKWebView) {
            guard !hasInjectedForCurrentPage else {
                print("📝 JavaScript already injected for current page, skipping...")
                return
            }
            
            // Debug data before injection
            validateDataBeforeInjection()
            
            hasInjectedForCurrentPage = true
            let js = createJavaScript()
            
            webView.evaluateJavaScript(js) { result, error in
                if let error = error {
                    print("❌ JS injection error: \(error.localizedDescription)")
                    // Reset flag to allow retry
                    self.hasInjectedForCurrentPage = false
                } else {
                    print("✅ JavaScript injected successfully for: \(webView.url?.absoluteString ?? "unknown")")
                }
            }
        }
        
        private func validateDataBeforeInjection() {
            print("🔍 Data validation before injection:")
            print("  candidateData: \(parent.candidateData.isEmpty ? "EMPTY" : "✓ \(parent.candidateData.count) chars")")
            print("  candidateInfo: \(parent.candidateInfo.isEmpty ? "EMPTY" : "✓ \(parent.candidateInfo.count) chars")")
            print("  currentUserJson: \(parent.currentUserJson.isEmpty ? "EMPTY" : "✓ \(parent.currentUserJson.count) chars")")
            print("  keyGuard: \(parent.keyGuard.isEmpty ? "EMPTY" : "✓")")
            print("  keyName: \(parent.keyName.isEmpty ? "EMPTY" : "✓")")
            print("  accessToken: \(parent.accessToken.isEmpty ? "EMPTY" : "✓")")
        }
        
        private func escapeForJavaScript(_ string: String) -> String {
            return string
                .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
                .replacingOccurrences(of: "\n", with: "\\n")
                .replacingOccurrences(of: "\r", with: "\\r")
                .replacingOccurrences(of: "\t", with: "\\t")
            }
    }
}

