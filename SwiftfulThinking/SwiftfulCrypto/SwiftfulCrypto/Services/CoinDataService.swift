//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 26/09/26.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    static let coinsURL = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: CoinDataService.coinsURL) else { return }
        
        coinSubscription = NetworkingManager.download(for: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
