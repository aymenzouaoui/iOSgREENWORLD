//
//  ItemView.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct ItemView: View {
    var item: WasteType
    @State private var image_type: UIImage? = nil
    var typeitem: TypeItem    //var typeitem:TypeItem
    @State private var isDetailActive = false
    
    @State private var qrCodeData: Data?=nil

    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: item.image_type)) { phase in
                switch phase {
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .cornerRadius(20)
                        .scaledToFit()
                        .frame(width :UIScreen.main.bounds.width / 3,height: 150)
                        .onAppear {
                            // Image loaded successfully
                            // Assigning the UIImage to the @State variable
                            image_type = uiImage(from: loadedImage)
                        }
                case .empty:
                    // Placeholder or fallback image
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width :UIScreen.main.bounds.width / 3,height: 150)

                        .cornerRadius(20)
                case .failure:
                    // Placeholder or fallback image on failure
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width :UIScreen.main.bounds.width / 3,height: 150)

                        .cornerRadius(20)
                @unknown default:
                    // Placeholder or fallback image for unknown state
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width :UIScreen.main.bounds.width / 3,height: 150)

                        .cornerRadius(20)
                }
            }
                .onTapGesture {
                    isDetailActive = true
                }
            
            HStack(spacing: 8) {
                Spacer(minLength: 0)
                Text(item.titre)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
            }
        }
        .padding(.top)
        .padding(.leading)
        .padding([.bottom, .trailing], 5)
        .background(
            typeitem.color.opacity(0.7)
                .clipShape(CustomCorner(corner: [.topLeft, .topRight, .bottomLeft], size: 25))
                .padding(.top, 55)
        )
        .fullScreenCover(isPresented: $isDetailActive) {
            DetailView(selectedItem: item, item: item)
        }

    }

    private func uiImage(from image: Image) -> UIImage {
        // Your UIImage conversion code
        // ...
        return UIImage(systemName: "photo")!
    }
}
