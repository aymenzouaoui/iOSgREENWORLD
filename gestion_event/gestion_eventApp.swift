//
//  gestion_eventApp.swift
//  gestion_event
//
//  Created by chaima saadallah on 1/12/2023.
//

import SwiftUI

@main
struct gestion_eventApp: App {
    let model = Model()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
