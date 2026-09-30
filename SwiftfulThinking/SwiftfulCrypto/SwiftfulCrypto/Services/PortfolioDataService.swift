//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 28/09/26.
//

import Foundation
import CoreData
import Combine

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedItems: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { [weak self] _, error in
            if let error {
                print("Error loading Core data container. \(error)")
            }
            self?.getPortfolioItems()
        }
    }
    
    func updatePortfolio(coin: CoinModel, with amount: Double) {
        if let portfolio = savedItems.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: portfolio, amount: amount)
            } else {
                delete(entity: portfolio)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // Private functions
    
    private func getPortfolioItems() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedItems = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching the request. \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolioItems()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving the data. \(error)")
        }
    }
}
