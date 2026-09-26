//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 25/09/26.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics = [
        StatisticModel(title: "Title 1", value: "Value 1", percentageChange: 10.5),
        StatisticModel(title: "Title 2", value: "Value 2"),
        StatisticModel(title: "Title 3", value: "Value 3"),
        StatisticModel(title: "Title 4", value: "Value 4", percentageChange: -15.2)
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService: CoinDataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(with text: String, in startingCoins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return startingCoins
        }
        
        let lowercaseText = text.lowercased()
        
        return startingCoins.filter { coin in
            coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
    }
}
