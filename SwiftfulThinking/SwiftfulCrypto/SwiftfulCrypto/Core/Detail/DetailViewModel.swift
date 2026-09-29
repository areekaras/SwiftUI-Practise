//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 29/09/26.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStats: [StatisticModel] = []
    @Published var additionalStats: [StatisticModel] = []
    @Published var coin: CoinModel
    @Published var coinDescription: String?
    @Published var websiteURL: String?
    @Published var redditURL: String?
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnCoinDetails in
                self?.overviewStats = returnCoinDetails.overview
                self?.additionalStats = returnCoinDetails.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                guard let self else { return }
                self.coinDescription = returnedCoinDetails?.readableDescription
                self.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailsModel: CoinDetailsModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        let overViewStats = createOverviewArray(coinModel: coinModel)
        let additionalStats = createAdditionalArray(coinDetailsModel: coinDetailsModel, coinModel: coinModel)
        return (overViewStats, additionalStats)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercent24Hr = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercent24Hr)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
    }
    
    private func createAdditionalArray(coinDetailsModel: CoinDetailsModel?, coinModel: CoinModel) -> [StatisticModel] {
        
        let high = "$" + (coinModel.high24H?.asCurrencyWith2Decimals() ?? "n/a")
        let highStat = StatisticModel(title: "24 High", value: high)
        
        let low = "$" + (coinModel.low24H?.formattedWithAbbreviations() ?? "n/a")
        let lowStat = StatisticModel(title: "24 Low", value: low)
        
        let priceChange24Hr = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentage24Hr = coinModel.priceChangePercentage24H
        let priceChange24HrStat = StatisticModel(title: "24h Price Change", value: priceChange24Hr, percentageChange: pricePercentage24Hr)
        
        let marketCapChange24Hr = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercent24Hr = coinModel.marketCapChangePercentage24H
        let marketCapChange24Stat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange24Hr, percentageChange: marketCapPercent24Hr)
        
        let blockTime = coinDetailsModel?.blockTimeInMinutes ?? 0
        let blockTimeValue = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: "Block Time", value: blockTimeValue)
        
        let hashingAlgorithm = coinDetailsModel?.hashingAlgorithm ?? "n/a"
        let hashingAlgorithmStat = StatisticModel(title: "Hashing Algorithm", value: hashingAlgorithm)
        
        return [
            highStat, lowStat, priceChange24HrStat, marketCapChange24Stat, blockTimeStat, hashingAlgorithmStat
        ]
    }
}
