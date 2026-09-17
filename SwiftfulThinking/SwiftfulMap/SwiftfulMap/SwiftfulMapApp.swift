//
//  SwiftfulMapApp.swift
//  SwiftfulMap
//
//  Created by Shibili Areekara on 17/09/26.
//

import SwiftUI

@main
struct SwiftfulMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
