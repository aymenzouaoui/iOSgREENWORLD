//
//  ProductViewModel.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 1/12/2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product]?

    func fetchProducts() {
        ProductService.shared.fetchProducts { [weak self] products in
            DispatchQueue.main.async {
                self?.products = products
            }
        }
    }
    func fetchProductDetails(id: String, completion: @escaping (Product?) -> Void) {
           ProductService.shared.fetchProductDetails(id: id) { product in
               DispatchQueue.main.async {
                   completion(product)
               }
           }
       }
}
