//
//  LocationsView.swift
//  SwiftUIMapApp
//
//  Created by Viktor Drykin on 17.06.2024.
//

import SwiftUI
import MapKit

struct LocationsView: View {

    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()

            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailsView(location: location)
        }
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationsList) {
                Text([vm.mapLocation.name, vm.mapLocation.cityName].joined(separator: ", "))
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180: 0))
                    }
            }

            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        )
    }

    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
                        )
                }
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
