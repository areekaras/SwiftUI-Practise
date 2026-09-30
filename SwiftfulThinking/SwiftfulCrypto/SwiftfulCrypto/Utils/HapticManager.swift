//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 28/09/26.
//

import SwiftUI

class HapticManager {
    
    static let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
