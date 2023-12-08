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

    var body: some Scene {
        WindowGroup {
            GestionUserSignIn()
               
        }
    }
}
