//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Shibili Areekara on 19/09/26.
//

import SwiftUI
import CoreData

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
