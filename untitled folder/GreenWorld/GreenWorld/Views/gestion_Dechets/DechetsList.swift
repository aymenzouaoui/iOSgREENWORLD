
//  DechetsList.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//


//
//  DechetsList.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//
//
//  DechetsList.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 30/11/2023.
//

import SwiftUI

struct DechetsList: View {
    @Binding var presentSideMenu: Bool
    @Binding var items: [WasteType]
    @State private var typeItem: TypeItem = TypeItem(color: .green, detail: "Some details")
    @State private var qrCodeData: Data?=nil

    @State private var search = ""
    @State private var detail = false
    @State private var selectedItem: WasteType?
    @State private var image: UIImage? = nil

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        presentSideMenu.toggle()
                    } label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    Spacer()
                }

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(spacing: 10) {
                            HStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .foregroundColor(.black)

                                TextField("Find something tasty", text: $search)
                            }

                            Divider()
                        }
                        .padding(.horizontal)

                               HStack(alignment: .top) {
                                   LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 20) {
                                       ForEach(items, id: \.id) { item in
                                           ItemView(item: item, typeitem: typeItem)
                                               .onTapGesture {
                                                   detail = true
                                                   selectedItem = item
                                               }
                                       }
                                   }
                                   .padding(.top, 10)
                        }
                        .padding()
                    }
                }
                .fullScreenCover(isPresented: $detail) {
                    if let selectedItem = selectedItem {
                        DetailView(selectedItem: selectedItem, item: selectedItem)
                    }
                }
            }
        }
    }
    private func uiImage(from image: Image) -> UIImage {
        // Your UIImage conversion code
        // ...
        return UIImage(systemName: "photo")!
    }
}
