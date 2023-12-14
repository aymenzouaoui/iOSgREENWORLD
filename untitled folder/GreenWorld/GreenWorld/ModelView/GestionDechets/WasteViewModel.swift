// WasteViewModel.swift

import Foundation
import SwiftUI

class WasteViewModel: ObservableObject {
    private var wasteService = WasteService()

    @Published var Type_dechets: String = ""
    @Published var date_depot: Date = Date()
    @Published var nombre_capacite: Int = 0  // Provide an initial value or initialize it in init()
    @Published var adresse: String = ""


    @Published var isShowingDetails: Bool = false

    // Add an initializer to initialize properties if needed
    init() {
        // You can initialize properties here if needed
    }

    func addWasteData() {
        wasteService.addWasteData(Type_dechets: Type_dechets, date_depot: date_depot, nombre_capacite: nombre_capacite, adresse: adresse ) { result in
            switch result {
            case .success(let newType):
                // Handle success, e.g., navigate to a new view
                print("Waste data added successfully: \(newType)")
                // Assuming you have a DetaildechetView to present
                DispatchQueue.main.async {
                    self.isShowingDetails = true
                }
            case .failure(let error):
                // Handle failure, e.g., show an error message
                print("Error adding waste data: \(error)")
            }
        }
    }
    
}
