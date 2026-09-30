//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 27/09/26.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var selectedCoin: CoinModel?
    @State var quantityText: String = ""
    @State var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButtons
                }
            }
            .onChange(of: vm.searchText) { newValue in
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(with: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear
                                        , lineWidth: 1)
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
    }
    
    private func updateSelectedCoin(with coin: CoinModel) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
            let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .font(.headline)
        .animation(.none)
        .padding()
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("SAVE")
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        guard let selectedCoin, let quantity = Double(quantityText) else { return 0 }
        return quantity * selectedCoin.currentPrice
    }
    
    private func saveButtonPressed() {
        guard let selectedCoin,
        let amount = Double(quantityText) else { return }
        
        // save to portfolio
        vm.update(coin: selectedCoin, with: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}

#Preview("dark") {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}

#Preview("dark") {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
        .preferredColorScheme(.dark)
}
