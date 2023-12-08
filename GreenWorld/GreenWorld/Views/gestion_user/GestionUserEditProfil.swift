import SwiftUI

struct GestionUserEditProfil: View {
    @State private var selectedImage: Image?
    @State private var showImagePicker = false
    @State private var selectedImageURL: URL?
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var phoneNumber: String = ""
    @State private var userImage: Image? = Image("user") // Remplacez "user" par le nom de votre image par défaut
    
    var body: some View {
        VStack {
            Button(action: {
                showImagePicker = true
            }) {
                userImage?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding()
            }
            
            Button(action: {
                uploadImage()
                updateUser()
            }) {
                Text("Save Image ")
            }
            
            TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green, lineWidth: 2)
                                    .padding(5)
                            )
                            .overlay(
                                HStack {
                                    Spacer().frame(width: 7) // Espacement supplémentaire à gauche de l'icône
                                    Image(systemName: "envelope")
                                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                }
                            )
                        
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green, lineWidth: 2)
                                    .padding(5)
                            )
                            .overlay(
                                HStack {
                                    Spacer().frame(width: 7) // Espacement supplémentaire à gauche de l'icône
                                    Image(systemName: "person")
                                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                }
                            )
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.green, lineWidth: 2)
                                    .padding(5)
                            )
                            .overlay(
                                HStack {
                                    Spacer().frame(width: 7) // Espacement supplémentaire à gauche de l'icône
                                    Image(systemName: "phone")
                                        .foregroundColor(Color(red: 0.13, green: 0.61, blue: 0.49))
                                        .frame(width: 20, height: 20)
                                    Spacer()
                                }
                            )
                        
            
            Button(action: {
                updateUser()
            }) {
                Text("Update Profile")
                    .font(Font.custom("Inter", size: 20).weight(.bold))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    .frame(width:200, height: 51)
                    .background(Color(red: 0.13, green: 0.61, blue: 0.49))
                    .cornerRadius(12)

            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(selectedImage: $selectedImage, selectedImageURL: $selectedImageURL, userImage: $userImage)
        }
    }
    
    private func uploadImage() {
        // Implémentez ici votre logique pour télécharger l'image sélectionnée
        // Vous pouvez utiliser la propriété selectedImageURL pour accéder à l'URL de l'image sélectionnée
        // Par exemple :
        if let imageURL = selectedImageURL {
            // Effectuez les opérations nécessaires pour télécharger l'image à partir de l'URL
            // ...
            
            // Mettez à jour l'image de l'utilisateur avec la nouvelle image téléchargée
            userImage = selectedImage
        }
    }
    
    private func updateUser() {
        // Implémentez ici votre logique pour mettre à jour le profil de l'utilisateur
        
        // Exemple de code pour mettre à jour l'utilisateur en utilisant une requête réseau
        guard let userURL = URL(string: "https://your_api_url.com/updateUser") else {
            return
        }
        
        let parameters: [String: Any] = [
            "userId": "123",
            "email": email,
            "username": username,
            "phoneNumber": phoneNumber
            // Ajoutez d'autres paramètres au besoin
        ]
        
        var request = URLRequest(url: userURL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Gérez la réponse du serveur
        }.resume()
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Image?
    @Binding var selectedImageURL: URL?
    @Binding var userImage: Image?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = Image(uiImage: image)
                
                if let imageURL = info[.imageURL] as? URL {
                    parent.selectedImageURL = imageURL
                }
                
                parent.userImage = parent.selectedImage
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct UserUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        GestionUserEditProfil()
    }
}

