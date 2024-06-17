//
//  Location.swift
//  SwiftUIMapApp
//
//  Created by Viktor Drykin on 17.06.2024.
//

import Foundation
import MapKit

struct Location: Identifiable {

    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String

    var id: String { name + cityName }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
