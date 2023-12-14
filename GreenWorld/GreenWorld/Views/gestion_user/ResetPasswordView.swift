import SwiftUI

struct ResetPasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isSuccess = false

    var body: some View {
        VStack {
            Image("YourImageName") // Replace "YourImageName" with your image's name
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100) // Adjust the size as needed
                .padding(.top)

            Text("Reset Password")
                .font(.title)
                .padding()

            SecureField("New Password", text: $newPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.green))

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.green))

            Button("Submit") {
                if newPassword == confirmPassword {
                    alertMessage = "Password has been reset successfully."
                    isSuccess = true
                } else {
                    alertMessage = "Passwords do not match. Please try again."
                    isSuccess = false
                }
                showAlert = true
            }
            .padding()
            .background(isSuccess ? Color.green : Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(isSuccess ? "Success" : "Error"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
