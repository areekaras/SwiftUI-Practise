//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 26/09/26.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: .none)
    }
}
