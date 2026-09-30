//
//  HomeStatsView.swift
//  SwiftfulCrypto
//
//  Created by Shibili Areekara on 26/09/26.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var showPortFolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticsView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortFolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortFolio: .constant(true))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
