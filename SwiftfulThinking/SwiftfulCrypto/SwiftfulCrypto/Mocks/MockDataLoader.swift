//
//  MockDataLoader.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 27/09/26.
//

import Foundation

class MockDataLoader {
    
    static func loadMockJsonData(for url: URL) -> Data? {
        print("[⚠️] Load from mock")
        
        switch url.absoluteString {
        case CoinDataService.coinsURL:
            return loadFromLocalJSON(fileName: "CoinMarketsAPI")
            
        case MarketDataService.globalURL:
            return loadFromLocalJSON(fileName: "GlobalAPI")
            
        default: break
        }
        
        return nil
    }
    
    static func loadFromLocalJSON(fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }
        
        return data
    }
}
