//
//  RouteDetailModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 08.05.2022.
//

import SwiftUI

struct RouteDetailModel: Identifiable {
    let id: String
    let name: String
    let stations: [Station]
}

extension RouteDetailModel {
    struct Station: Identifiable {
        let id: Int
        let name: String
        let date: Date
        let time: String?
        let distance: String
        let price: String
    }
    
    struct Place: Identifiable {
        let id: Int
        let isAvailable: Bool
    }
}

extension RouteDetailModel: SelectIdentifiable {}
