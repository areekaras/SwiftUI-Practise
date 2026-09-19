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
    
    init() {
        getBusinesses()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<Business>(entityName: "Business")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch {
            print("Fetch error \(error)")
        }
    }
    
    func addBusiness() {
        let newBusiness = Business(context: manager.context)
        newBusiness.name = "Apple"
        
        // Add existing deparment to the new business
        // newBusiness.departments = []
        
        // Add existing employees to the new business
        // newBusiness.employees = []
        
        // Add new business to the existing department
        // newBusiness.addToDepartments(<#T##value: Department##Department#>)
        
        // Add new employees to the existing employees
        // newBusiness.addToEmployees(<#T##value: Employee##Employee#>)
        
        
        save()
    }
    
    func save() {
        manager.save()
        getBusinesses()
    }
    
}

struct RelationshipBootcamp: View {
    
    @StateObject var vm: RelationshipViewModel = RelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
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
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(business: business)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View {
    var business: Business
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Name: \(business.name ?? "")")
                .bold()
                
            if let departments = business.departments?.allObjects as? [Department] {
                Text("Departments:")
                    .bold()
                
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = business.employees?.allObjects as? [Employee] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    RelationshipBootcamp()
}
