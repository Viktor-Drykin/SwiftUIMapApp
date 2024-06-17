//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Viktor Drykin on 17.06.2024.
//

import Foundation

class LocationsViewModel: ObservableObject {

    @Published var locations: [Location]

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }

}
