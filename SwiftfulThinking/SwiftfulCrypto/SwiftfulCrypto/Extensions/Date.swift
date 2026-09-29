//
//  Date.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 29/09/26.
//

import Foundation

extension Date {
    
    init(coinGeckoDateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // "2021-03-13T23:18:10.268Z"
        let date = dateFormatter.date(from: coinGeckoDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
