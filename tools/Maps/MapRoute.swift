//
//  MapView.swift
//  pruebas
//
//  Created by Juan Luis Flores on 26/05/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var routePolyline: MKPolyline?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.380, longitude: -101.003),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    var body: some View {
        ZStack {
            Map(initialPosition: .region(region)) {
                
                if let polyline = routePolyline {
                    MapPolyline(polyline)
                        .stroke(Color.blue, lineWidth: 5)
                }
            }
            .mapControls {
                MapUserLocationButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Spacer()
                Button("Get Directions") {
                    getRoute()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, 40)
            }
        }
    }

    func getRoute() {
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 25.380, longitude: -101.003)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 25.686, longitude: -100.316)

        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else {
                print("No route found.")
                return
            }

            DispatchQueue.main.async {
                self.routePolyline = route.polyline
                self.region = MKCoordinateRegion(route.polyline.boundingMapRect)
            }
        }
    }
}

#Preview {
    MapView()
}
