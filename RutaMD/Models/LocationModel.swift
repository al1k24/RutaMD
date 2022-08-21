//
//  LocationModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import Foundation
import CoreLocation

struct LocationModel: Identifiable {
    let id: String
    let name: String
    let address: String
    let phone: String
    let coordinate: CLLocationCoordinate2D
}
