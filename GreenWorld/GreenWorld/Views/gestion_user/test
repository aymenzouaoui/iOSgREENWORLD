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
                .padding(EdgeInsets(top: 25, leading: 20, bottom: 0, trailing: 20))

            Text("Enter the validation code sent to your email.")
                .foregroundColor(Color.accentColor)
                .font(.system(size: 18, weight: .bold))
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))

            HStack(spacing: 20) {
                ForEach(0..<4) { index in
                    TextField("", text: binding(for: index))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 50, height: 50)
                        .font(.system(size: 50, weight: .bold))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                }
            }
            .padding(EdgeInsets(top: 15, leading: 20, bottom: 0, trailing: 20))
            NavigationLink(destination: GestionUserSignIn()
 ) {
     Text("Verify")
 }
 .frame(maxWidth: .infinity)
 .padding()
 .background(Color.green)
 .foregroundColor(.white)
 .cornerRadius(8)
 .padding(EdgeInsets(top: 200, leading: 20, bottom: 0, trailing: 20))
        
            
           Text("Didn't receive the code?")
                .foregroundColor(Color.black)
                .font(.system(size: 20, weight: .bold))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            NavigationLink(destination: GestionUserSignIn(), isActive: $navigationLinkActive) {
                   EmptyView()
               }
               Button(action: {
                   navigationLinkActive = true
                 
               })  {
                Text("Resend Code")
                    .foregroundColor(Color.green)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
            }
        }
        } }

    private func binding(for index: Int) -> Binding<String> {
        switch index {
        case 0:
            return $code1
        case 1:
            return $code2
        case 2:
            return $code3
        case 3:
            return $code4
        default:
            fatalError("Index out of range")
        }
    }
}

struct UserValidationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        UserValidationCodeView()
    }
}
