//
//  SwiftUIMapAppApp.swift
//  SwiftUIMapApp
//
//  Created by Viktor Drykin on 16.06.2024.
//

import SwiftUI

@main
struct SwiftUIMapAppApp: App {

    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
