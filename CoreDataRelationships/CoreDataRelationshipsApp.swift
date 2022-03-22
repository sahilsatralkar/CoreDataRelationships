//
//  CoreDataRelationshipsApp.swift
//  CoreDataRelationships
//
//  Created by Sahil Satralkar on 22/03/22.
//

import SwiftUI

@main
struct CoreDataRelationshipsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
