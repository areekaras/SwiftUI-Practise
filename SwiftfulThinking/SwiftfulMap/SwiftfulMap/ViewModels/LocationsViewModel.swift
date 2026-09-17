//
//  LocationsViewModel.swift
//  SwiftfulMap
//
//  Created by Shibili Areekara on 17/09/26.
//

import SwiftUI
import Combine
import MapKit

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(for: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        updateMapRegion(for: self.mapLocation)
    }
    
    private func updateMapRegion(for location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(with location: Location) {
        withAnimation(.easeInOut) {
            self.mapLocation = location
            showLocationsList = false
        }
    }
}
