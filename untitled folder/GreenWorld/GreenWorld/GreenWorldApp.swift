//
//  GreenWorldApp.swift
//  GreenWorld
//
//  Created by ChaimaEljed on 27/11/2023.
//

import SwiftUI

@main
struct GreenWorldApp: App {
    let persistenceController = PersistenceController.shared
@StateObject private var model = Model()
    var body: some Scene {
        WindowGroup {
            GestionUserSignIn()
                .environmentObject(model)
               
        }
    }
}
