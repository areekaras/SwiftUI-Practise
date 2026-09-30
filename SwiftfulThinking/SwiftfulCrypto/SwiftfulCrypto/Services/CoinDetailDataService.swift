//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 29/09/26.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailsModel?
    
    private var coinDetailSubscription: AnyCancellable?
    private let coin: CoinModel
    
    static func coinDetailURL(of coin: CoinModel) -> String {
        return "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false&include_categories_details=false"
    }
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    private func getCoinDetails() {
        guard let url = URL(string: CoinDetailDataService.coinDetailURL(of: coin)) else { return }
        
        coinDetailSubscription = NetworkingManager.download(for: url)
            .decode(type: CoinDetailsModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
