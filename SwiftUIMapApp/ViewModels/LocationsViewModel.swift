//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Viktor Drykin on 17.06.2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {

    @Published var locations: [Location]

    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }

    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    @Published var showLocationsList = false

    @Published var sheetLocation: Location? = nil

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first! // just because we are learning SwiftUI
        updateMapRegion(location: locations.first!)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }

    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }

    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }

    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            return
        }
        let nextIndex = currentIndex + 1

        let nextLocation: Location? = {
            if locations.indices.contains(nextIndex) {
                return locations[nextIndex]
            }
            return locations.first
        }()

        if let nextLocation = nextLocation {
            showNextLocation(location: nextLocation)
        }
    }

}
