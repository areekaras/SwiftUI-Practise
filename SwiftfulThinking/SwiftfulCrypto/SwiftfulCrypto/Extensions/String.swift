//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 29/09/26.
//

import Foundation

extension String {
    func removingHTMLOccurances() -> String {
        return replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
