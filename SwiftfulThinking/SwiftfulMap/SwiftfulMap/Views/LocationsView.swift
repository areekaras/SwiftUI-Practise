//
//  LocationsView.swift
//  SwiftfulMap
//
//  Created by Shibili Areekara on 17/09/26.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack {
                headerView
                    .padding()
                
                Spacer()
            }
        }
    }
}

extension LocationsView {
    var headerView: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
        
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(
            color: .black.opacity(0.3),
            radius: 20,
            x: 0,
            y: 15
        )
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
