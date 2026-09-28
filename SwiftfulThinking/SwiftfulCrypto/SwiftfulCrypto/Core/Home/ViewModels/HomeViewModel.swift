//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 25/09/26.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics = [StatisticModel]()
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading = false
    @Published var searchText: String = ""
    
    
    private let coinDataService: CoinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedItems)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func update(coin: CoinModel, with amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, with: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats = [StatisticModel]()
        
        guard let marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: marketDataModel.marketCap, percentageChange: marketDataModel.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: marketDataModel.volume)
        let btsDominance = StatisticModel(title: "BTC Dominance", value: marketDataModel.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = StatisticModel(
            title: "Portfolio value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange
        )
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btsDominance,
            portfolio
        ])
        return stats
    }
}
