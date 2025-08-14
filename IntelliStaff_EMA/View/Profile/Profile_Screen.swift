//
//  Profile_Screen.swift
//  IntelliStaff_EMA
//
//  Created by ios on 13/08/25.
//

import SwiftUI
import WebKit

enum NavigationDestination: Hashable {
    case webView(apiKey: String)
    
}
struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}


//struct WebViewHold: UIViewRepresentable {
//    let url: URL
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        print("Loading URL:", url)
//        let request = URLRequest(url: url)
//        uiView.load(request)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            print("✅ WebView finished loading")
//        }
//
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            print("❌ WebView navigation failed:", error.localizedDescription)
//        }
//
//        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//            print("❌ WebView provisional load failed:", error.localizedDescription)
//        }
//    }
//}


struct ProfileModalView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showLogoutAlert = false
    @State private var showWebView = false
    @State private var webViewURL: IdentifiableURL?


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.profileItems) { item in
                    VStack(spacing: 8) {
                        HStack(spacing: 12) {
                            // Icon with fixed frame to align text
                            Image(systemName: item.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .frame(width: 25, alignment: .leading) // ← Ensures fixed icon width

                            // Text starts at consistent left point
                            Text(item.title)
                                .font(.titleFont)
                                .foregroundColor(.primary)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 5)
                        .padding(.top, 16)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            handleItemTap(item)
                        }

                        DottedLine()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [2, 6]))
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(height: 1)
                            .padding(.horizontal, 5)
                            .padding(.bottom, 8)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchProfileData()
        }
        .navigationTitle("Profile")
    }



    private func handleItemTap(_ item: ProfileItem) {
            print("Tapped on \(item.title) with ID: \(item.id)")

            if item.title.lowercased() == "logout" {
                showLogoutAlert = true
            } else if let url = URL(string: "https://www.google.com/") {
                webViewURL = IdentifiableURL(url: url)
                showWebView = true
            }
            
        
    }


    private func performLogout() {
        // Add logout logic here
        print("User logged out")
    }
}







struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalPreviewWrapper()
    }

    struct ProfileModalPreviewWrapper: View {
        @State private var showModal = true

        var body: some View {
             ProfileModalView()
        }
    }
}
