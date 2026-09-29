//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 29/09/26.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
        
    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    
    init(coin: CoinModel) {
        self._vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("[🧿] Detail view initialized for \(coin.name)")
    }
    
    var body: some View {
        Text(vm.coinDetails?.name ?? "")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
