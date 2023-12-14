import SwiftUI

struct GestionUserForgetPassword: View {
    @State private var selectedMethod = "Email"
    @State private var emailOrPhone: String = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
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

                Image("validation") // Make sure this image is included in your assets
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
                    // Implement the action to resend the code
                }
                .foregroundColor(Color.blue)
                .padding()

                NavigationLink(destination: UserValidationCodeView(), isActive: $navigateToValidation) {
                    Button("Validate") {
                        // Perform validation logic if necessary
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
                    title: Text(alertTitle),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .navigationBarHidden(true)
        }
    }
}



struct GestionUserForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        GestionUserForgetPassword()
    }
}
