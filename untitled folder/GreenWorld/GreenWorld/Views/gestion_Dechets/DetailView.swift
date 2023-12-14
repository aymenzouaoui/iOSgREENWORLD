//
//  DetailView.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct DetailView: View {
    @State private var isShowingForm: Bool = false
    var selectedItem: WasteType  // Use your actual item type here
    @State private var image: UIImage? = nil
    @Environment(\.presentationMode) var present
    @State var isSmallDevice = UIScreen.main.bounds.height < 850
    var item: WasteType
    
    @State private var qrCodeData: Data?=nil

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    present.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 0)
            }
            .padding([.horizontal, .top])
            
            VStack(alignment: .leading, spacing: 10) {
                Text(selectedItem.titre)
                                   .font(.system(size: isSmallDevice ? 35 : 50, weight: .heavy))
                                   .foregroundColor(Color("Color3"))
             
            }
            .padding(.top)
            
            VStack {
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Image("doll")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                        
                        Text("Recycle Now")
                            .fontWeight(.bold)
                            .foregroundColor(Color.black
                                                .opacity(0.6))
                        // defailt Frame
                            .frame(height: 50)
                        
                    }
                    
                    AsyncImage(url: URL(string: selectedItem.image_type)) { phase in
                        switch phase {
                        case .success(let loadedImage):
                            loadedImage
                                .resizable()
                                .cornerRadius(20)
                                .scaledToFit()
                                .onAppear {
                                    // Image loaded successfully
                                    // Assigning the UIImage to the @State variable
                                    image = uiImage(from: loadedImage)
                                }
                        case .empty:
                            // Placeholder or fallback image
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                        case .failure:
                            // Placeholder or fallback image on failure
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                        @unknown default:
                            // Placeholder or fallback image for unknown state
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(20)
                        }
                    }
                        .frame(width: UIScreen.main.bounds.width / 2)
                        .offset(y: isSmallDevice ? 20 : -20)
                        .padding(.top, -25)
                }
                
                Text(item.description)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.black.opacity(0.6))
                    .multilineTextAlignment(.leading)
                    .padding(.top)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 20) {
                    Button(action: {}) {
                        Image(systemName: "suit.heart.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Color3"))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        isShowingForm = true
                    }) {

                        HStack(spacing: 10) {
                            Text("envoyer votre Demande")
                                .font(isSmallDevice ? .none : .title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)

                    
                            Image(systemName: "chevron.right")
                                .font(.system(size: isSmallDevice ? 15 : 22, weight: .heavy))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color("Color3"))
                        .clipShape(Capsule())
                    }.sheet(isPresented: $isShowingForm) {
                       
                        DechetsForm(item: selectedItem)                    }
                    .padding(.vertical)
                }
            }
            .padding()
            .background(
                Color("pink")
                   .clipShape(CustomShape())
            )
            .padding()
        }
    }
    private func uiImage(from image: Image) -> UIImage {
        // Your UIImage conversion code
        // ...
        return UIImage(systemName: "photo")!
    }
}


