//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 27/09/26.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel?
    private var marketDataSubscripton: AnyCancellable?
    
    static let globalURL = "https://api.coingecko.com/api/v3/global"
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: MarketDataService.globalURL) else { return }
        
        marketDataSubscripton = NetworkingManager.download(for: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscripton?.cancel()
            })
    }
}
