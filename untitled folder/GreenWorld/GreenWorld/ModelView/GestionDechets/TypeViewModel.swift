//
//  TypeViewModel.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 4/12/2023.
//

import SwiftUI

class TypeViewModel: ObservableObject {
    @Published var items: [WasteType] = []
    private var typeService = TypedechetsServices()

    func getAllTypes() {
        typeService.getAllTypes { [weak self] items in
            DispatchQueue.main.async {
                if let items = items {
                    self?.items = items
                    print("Fetched items: \(items)")
                } else {
                    print("Failed to fetch items.")
                }
            }
        }
    }
}

