//
//  RelationshipBootcamp.swift
//  CoreDataBootcamp
//
//  Created by Shibili Areekara on 19/09/26.
//

import SwiftUI
import Combine
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "RelationshipBootCamp")
        container.loadPersistentStores { _, error in
            if let error {
                print("Could not load persistent store \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Could not save data \(error)")
        }
        
    }
}


class RelationshipViewModel: ObservableObject {
    
}

struct RelationshipBootcamp: View {
    
    @StateObject var vm: RelationshipViewModel = RelationshipViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RelationshipBootcamp()
}
