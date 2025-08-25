import SwiftUI

// MARK: - Settings Screen

struct SettingsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingsViewModel()
    @State private var name: String = "\(UserDefaults.standard.value(forKey: "Username") as? String ?? "")"
    @State private var email: String = "\(UserDefaults.standard.value(forKey: "email") as? String ?? "")"
    @State private var showTopTab = false
   
    var body: some View {
        ScrollView {
            VStack(spacing: 14) {   // ↓ smaller spacing
                // Name
                LabeledField(title: "Name") {
                    TextField("", text: $name)
                        .textInputAutocapitalization(.words)
                        .font(.system(size: 16, weight: .regular))   // ↓ smaller
                        .padding(.vertical, 12)   // ↓ reduced
                        .padding(.horizontal, 12)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // Email
                LabeledField(title: "Email") {
                    HStack(spacing: 10) {
                        Image(systemName: "envelope")
                            .font(.system(size: 16))   // ↓ smaller
                            .frame(width: 14, height: 14)
                        TextField("", text: $email)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                            .font(.system(size: 16, weight: .regular))  // ↓ smaller
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                }
                
                // Toggles
                VStack(spacing: 12) {
                    ToggleCard(title: "Turn on/off your location sharing", isOn: $viewModel.shareLocation)
                    ToggleCard(title: "Turn on/off app notifications", isOn: $viewModel.appNotifications)
                    ToggleCard(title: "Set as primary device", isOn: Binding(
                        get: { viewModel.primaryDevice },
                        set: { newValue in
                            viewModel.primaryDevice = newValue
                            viewModel.updatePrimaryDevice(isOn: newValue)
                            if viewModel.status { }
                        }
                    ))
                }
            }
            .padding(.horizontal, 14)
            .padding(.top, 10)
            .padding(.bottom, 20)
            .background(AppColors.screenBg.ignoresSafeArea())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))   // ↓ smaller
                    }
                }
            }
//            .alert("CMA 2.0", isPresented: $viewModel.showAlert) {
//                Button("OK", role: .cancel) { showTopTab = true }
//            } message: {
//                Text(viewModel.alertMessage)
//            }
            AlertView(
                title: "CMA 2.0",
                message: viewModel.alertMessage,
                primaryButton: AlertButtonConfig(title: "OK") {
                    viewModel.showAlert = false
                },
                dismiss: {
                    viewModel.showAlert = false
                },
            )
        }
    }

    struct LabeledField<Content: View>: View {
        let title: String
        @ViewBuilder var content: Content
        
        init(title: String, @ViewBuilder content: () -> Content) {
            self.title = title
            self.content = content()
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.subheadline)   // ↓ smaller
                    .foregroundColor(Color(.darkGray))
                content
            }
        }
    }

    struct ToggleCard: View {
        let title: String
        @Binding var isOn: Bool
        
        var body: some View {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))   // ↓ smaller
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 10)
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .toggleStyle(CompactPillToggleStyle())
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .background(RoundedRectangle(cornerRadius: 12).fill(.white))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray4), lineWidth: 1))
            .shadow(color: Color.black.opacity(0.02), radius: 1, x: 0, y: 1)
        }
    }

    struct CompactPillToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            Button {
                configuration.isOn.toggle()
            } label: {
                ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                    Capsule()
                        .fill(Color(.systemGray3))
                        .frame(width: 48, height: 24)   // ↓ smaller
                    Circle()
                        .fill(Color.black)
                        .frame(width: 20, height: 20)   // ↓ smaller
                        .padding(2)
                }
            }
            .buttonStyle(.plain)
            .animation(.easeInOut(duration: 0.15), value: configuration.isOn)
        }
    }

    enum AppColors {
        static let screenBg = Color(red: 0.97, green: 0.95, blue: 0.98)
    }
}
