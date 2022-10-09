//
//  TestView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI
import MapKit


import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
//    28.801910%2C46.998159
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis", latitude: 46.998159, longitude: 28.801910)
    static let example2 = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis", latitude: 36.998159, longitude: 38.801910)

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

@MainActor class ViewModel: ObservableObject {
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 47.2879608, longitude: 28.5670941), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @Published private(set) var locations: [Location] = [.example, .example2]
    @Published var selectedPlace: Location?

}

struct TestView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding(12)
                        .background(Color.Theme.background)
                        .overlay(with: .circle)
                        .foregroundColor(Color.hex3C71FF)
                        .offset(x: 12)
                        .zIndex(1)

                    Text(location.name)
                        .fixedSize()
                        .padding(.leading, 8)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.Theme.background)
                        .overlay(with: .roundedRectangle(cornerRadius: 8))
                }
                .onTapGesture {
                    viewModel.selectedPlace = location
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
