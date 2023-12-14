import SwiftUI
import CoreImage.CIFilterBuiltins

struct DechetsForm: View {
    @ObservedObject private var viewModel = WasteViewModel()
    @State private var isShowingDetails = false
    var item: WasteType

    var body: some View {
        NavigationView {
            ZStack {
                Color.green1
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.80)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Recycle")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.green)
                    
                    TextField(item.titre, text: $viewModel.Type_dechets)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onAppear {
                            // Set the initial value of Type_dechets to item.titre when the view appears
                            viewModel.Type_dechets = item.titre
                        }
                    
                    DatePicker("Date et heure", selection: $viewModel.date_depot, displayedComponents: [.date, .hourAndMinute])
                        .padding()
                    
                    TextField("Capacité", text: Binding(
                        get: { String(viewModel.nombre_capacite) },
                        set: { viewModel.nombre_capacite = Int($0) ?? 0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    TextField("Adresse", text: $viewModel.adresse)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    NavigationLink(destination: DetaildechetView(type_dechets: viewModel.Type_dechets, date_depot: viewModel.date_depot, nombre_capacite: viewModel.nombre_capacite, adresse: viewModel.adresse, qrCodeData: generateQRCodeData()), isActive: $isShowingDetails) {
                        EmptyView()
                    }
                    .hidden()
                    
                    Button(action: {
                        viewModel.addWasteData()
                        isShowingDetails = true
                    }) {
                        Text("Envoyer")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .navigationBarTitle("", displayMode: .inline)
                
                VStack {
                    Image("22")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .padding(.top, -280)
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func generateQRCodeData() -> Data {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        let qrCodeString = """
            \(viewModel.Type_dechets)
            \(dateFormatter.string(from: viewModel.date_depot))
            \(viewModel.nombre_capacite)
            \(viewModel.adresse)
        """
        
        print("QR Code String:", qrCodeString)
        
        return qrCodeString.data(using: .utf8) ?? Data()
    }
}
