import SwiftUI

struct UserValidationCodeView: View {
    @State private var navigationLinkActive: Bool = false
    @State private var code1: String = ""
    @State private var code2: String = ""
    @State private var code3: String = ""
    @State private var code4: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.blue)
                    Spacer()
                }
                .padding()

                Text("Confirmation")
                    .foregroundColor(Color.green)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 25)

                Text("Enter the validation code sent to your email.")
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.top, 20)

                HStack(spacing: 15) {
                    ForEach(0..<4, id: \.self) { index in
                        CodeInputField(text: binding(for: index))
                    }
                }
                .padding(.top, 15)

                Button(action: {
                    // Implement validation logic here
                }) {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 200)

                Button(action: {
                    // Implement resend code logic here
                }) {
                    Text("Didn't receive the code? Resend Code")
                        .foregroundColor(Color.green)
                }
                .padding(.top, 10)
            }
            .navigationBarHidden(true)
        }
    }

    private func binding(for index: Int) -> Binding<String> {
            switch index {
            case 0: return $code1
            case 1: return $code2
            case 2: return $code3
            case 3: return $code4
            default: fatalError("Index out of range")
            }
        }
    }

    struct CodeInputField: View {
        @Binding var text: String

        var body: some View {
            TextField("", text: $text)
                .onChange(of: text) { newValue in
                    // Restrict input to numbers only and limit length to 1
                    if newValue.count > 1 || !newValue.allSatisfy({ $0.isNumber }) {
                        text = String(newValue.prefix(1))
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 50, height: 50)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
        }
    }
struct UserValidationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserValidationCodeView()
    }
}
