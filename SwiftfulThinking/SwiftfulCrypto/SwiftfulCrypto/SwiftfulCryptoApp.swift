//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 25/09/26.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    @State private var showLaunchView = false // true // change back
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        
        UITableView.appearance().backgroundColor = UIColor.clear
        
        // Not working for detail screen - should be use of depricated navigation view
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
        UIBarButtonItem.appearance().tintColor = UIColor(Color.theme.accent)
        
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(.stack)
                .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
