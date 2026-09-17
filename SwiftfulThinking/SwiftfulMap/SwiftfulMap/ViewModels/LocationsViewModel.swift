//
//  LocationsViewModel.swift
//  SwiftfulMap
//
//  Created by Shibili Areekara on 17/09/26.
//

import Combine

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        self.locations = LocationsDataService.locations
    }
}
