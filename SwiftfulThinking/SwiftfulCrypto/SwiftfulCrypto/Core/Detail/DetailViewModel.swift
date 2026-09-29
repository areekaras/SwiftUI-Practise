//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 29/09/26.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var coinDetails: CoinDetailsModel?

    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { [weak self] returnCoinDetails in
                print("RECEIVED COIN DETAIL DATA")
                self?.coinDetails = returnCoinDetails
            }
            .store(in: &cancellables)
    }
}
