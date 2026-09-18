//
//  LocationsListView.swift
//  SwiftfulMap
//
//  Created by Shibili Areekara on 17/09/26.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button(action: {
                    vm.showNextLocation(with: location)
                }) {
                    listRowView(with: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                
                    
            }
        }
        .listStyle(.plain)
    }
}

extension LocationsListView {
    func listRowView(with location: Location) -> some View {
        HStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}
