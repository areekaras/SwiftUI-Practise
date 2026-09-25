//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 25/09/26.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.allCoins = [DeveloperPreview.instance.coin]
            self?.portfolioCoins = [DeveloperPreview.instance.coin]
        }
    }
}
