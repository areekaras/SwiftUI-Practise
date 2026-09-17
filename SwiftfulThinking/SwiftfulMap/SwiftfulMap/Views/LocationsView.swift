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
            mapLayer
                .ignoresSafeArea()
            
            VStack {
                headerView
                    .padding()
                Spacer()
                locationsPreviewsStack
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
    
    var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                 LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1.0 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(with: location)
                    }
            }
        })
    }
    
    var locationsPreviewsStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: vm.mapLocation)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(AnyTransition.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
