import SwiftUI

struct SettingsScreen: View {
    
    @State private var viewModel = SettingsViewModel()
    @State private var name: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State private var email: String = UserDefaults.standard.string(forKey: "Username") ?? ""
    @Binding var path: [AppRoute]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    
                    VStack {
                        UnderlinedTF(title: "Name", text: $name)
                        UnderlinedTF(title: "Email", text: $email)
                    }
                    
                    VStack {
                        SimpleToggleCard(title: "Turn on/off your location sharing", isOn: $viewModel.shareLocation)
                        SimpleToggleCard(title: "Turn on/off app notifications", isOn: $viewModel.appNotifications)
                        SimpleToggleCard(title: "Set as primary device", isOn: $viewModel.primaryDevice)
                    }
                    .padding(.top, 50)
   
                }
                .padding(.top, 50)
                .padding(.horizontal, 15)
            }
            
            // Custom Alert overlay
            if viewModel.showAlert {
                AlertView(
                    title: "Primary Device",
                    message: viewModel.alertMessage,
                    primaryButton: AlertButtonConfig(title: "OK") {
                        viewModel.showAlert = false
                    },
                    dismiss: {
                        viewModel.showAlert = false
                    }
                )
                .zIndex(1)
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()

                TriangleLoader()
            }
            
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.white)
                }
            }
        }
    }
}


#Preview {
    struct SettingsScreennPreviewWrapper: View {
        @State private var path: [AppRoute] = []

        var body: some View {
            NavigationStack(path: $path) {
                SettingsScreen(path: $path)
            }
        }
    }

    return SettingsScreennPreviewWrapper()
}

