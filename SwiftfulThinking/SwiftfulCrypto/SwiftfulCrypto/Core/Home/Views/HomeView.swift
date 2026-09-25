//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 25/09/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    CircleButtonView(iconName: "info")
                    Spacer()
                    Text("Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                }
                .padding(.horizontal)
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
}
