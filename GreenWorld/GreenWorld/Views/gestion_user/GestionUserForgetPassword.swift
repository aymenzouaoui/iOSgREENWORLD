import SwiftUI

struct GestionUserForgetPassword: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var selectedMethod = "Email"
    @State private var emailOrPhone: String = ""
    @State private var showAlert = false
    @State private var navigateToValidation = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.blue)
                    Spacer()
                }
                .padding()

                Spacer()

                Image("validation") // Ensure this image is in your assets
                    .resizable()
                    .frame(width: 262, height: 236)
                    .padding(.top, 20)

                Picker("Method", selection: $selectedMethod) {
                    Text("Email").tag("Email")
                    Text("Phone Number").tag("Phone")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)

                TextField(selectedMethod == "Email" ? "Email" : "Phone Number", text: $emailOrPhone)
                    .keyboardType(selectedMethod == "Email" ? .emailAddress : .phonePad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)

                Button("Resend Code") {
                    if selectedMethod == "Email" {
                        resendCode()
                    } else {
                        // Handle phone number case if necessary
                    }
                }
                .foregroundColor(Color.blue)
                .padding()

                NavigationLink(destination: UserValidationCodeView(email: emailOrPhone), isActive: $navigateToValidation) {
                    Button("Validate") {
                        navigateToValidation = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                }

                Spacer()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Message"),
                
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarHidden(true)
        }
    }

    private func resendCode() {
        userViewModel.sendResetCode(email: emailOrPhone)
        showAlert = true
    }
}

struct GestionUserForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        GestionUserForgetPassword()
    }
}
