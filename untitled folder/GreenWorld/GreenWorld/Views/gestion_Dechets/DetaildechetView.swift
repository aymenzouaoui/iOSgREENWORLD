//
//  DetaildechetView.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import UIKit

struct DetaildechetView: View {
    var type_dechets: String
    var date_depot: Date
    var nombre_capacite: Int
    var adresse: String
    var qrCodeData: Data
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " dd MM yyyy 'at' h:mm a"
        return dateFormatter.string(from: date_depot)
    }
    
    var body: some View {
        ZStack {
            Color.green1
                .ignoresSafeArea()
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                Text("Recycle")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(.green)
                
                VStack {
                    // Display the details as you wish
                    Text("Type de Déchets:") .bold()
                        .foregroundColor(.green)
                    Text("\(type_dechets)")
                        .padding()
                    
                    Text(" Date de dépôt:") .bold()
                        .foregroundColor(.green)
                    Text("\(formattedDate)")
                        .padding()
                    
                    Text(" Capacite en g :") .bold()
                        .foregroundColor(.green)
                    Text("\(nombre_capacite)")
                        .padding()
                    
                    Text("  Adresse :") .bold()
                        .foregroundColor(.green)
                    Text(" \(adresse)")
                    
                        .padding()
                    let uiImage = generateQRCodeImage()
                       return Image(uiImage: uiImage)
                           .resizable()
                           .scaledToFit()
                           .frame(width: 200, height: 200) // Adjust size as needed

                       // Print statement to check if the uiImage is generated correctly
                       print("QR Code Image Size:", uiImage.size)

                }
            }
        }
    }
    
    // Function to generate QR code image from data
    private func generateQRCodeImage() -> UIImage {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return UIImage() }
        filter.setValue(qrCodeData, forKey: "inputMessage")
        
        guard let ciImage = filter.outputImage else { return UIImage() }
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return UIImage() }
        
        let uiImage = UIImage(cgImage: cgImage)
        return uiImage
    }
}
