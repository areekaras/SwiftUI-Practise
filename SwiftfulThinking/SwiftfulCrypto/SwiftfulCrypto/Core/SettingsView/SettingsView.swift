//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 30/09/26.
//

import SwiftUI

/*
 The links and content of the screen are not accurate as per course this is study project. 
 */

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/playlist?list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let developerURL = URL(string: "https://www.shibiliareekara.com")!
    let coinGeckoURL = URL(string: "https://www.coingecko.com")!
    
    
    var body: some View {
        NavigationView {
            List {
                swiftfulThinkingSection
                coinGeckoSection
                developerSection
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(.grouped)
            .navigationTitle("Settings View")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

extension SettingsView {
    
    private var swiftfulThinkingSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This is Crypto Tracker App implemented with SwiftUI with fully coded in Swift. Used MVVM, Combine, etc")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Subscribe on Youtube 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: coffeeURL)
        } header: {
            Text("Swiftful Thinking".uppercased())
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("This is Crypto Tracker App implemented with SwiftUI with fully coded in Swift. Used MVVM, Combine, etc")
                    .font(.callout)
            }
            Link(destination: coinGeckoURL) {
                Text("Learn More here 🦎")
                    .font(.headline)
            }
        } header: {
            Text("CoinGecko")
                .font(.caption)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
        }
        .accentColor(.blue)
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("This is Crypto Tracker App implemented with SwiftUI with fully coded in Swift. Used MVVM, Combine, etc")
                    .font(.callout)
            }
            Link(destination: developerURL) {
                Text("Learn More here 🥳")
                    .font(.headline)
            }
        } header: {
            Text("Developer")
                .font(.caption)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
        }
        .accentColor(.blue)
    }
}

#Preview {
    SettingsView()
}
