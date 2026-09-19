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
            print("Saved successfully!")
        } catch {
            print("Could not save data \(error)")
        }
        
    }
}


class RelationshipViewModel: ObservableObject {
    
    var manager = CoreDataManager.shared
    
    @Published var businesses: [Business] = []
    
    func addBusiness() {
        let newBusiness = Business(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }
    
    func save() {
        manager.save()
    }
    
}

struct RelationshipBootcamp: View {
    
    @StateObject var vm: RelationshipViewModel = RelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Button {
                    vm.addBusiness()
                } label: {
                    Text("Perform Action")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.02008849755, green: 0.198356837, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Business")
        }
    }
}

#Preview {
    RelationshipBootcamp()
}
