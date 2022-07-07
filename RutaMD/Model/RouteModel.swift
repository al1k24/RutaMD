//
//  RouteModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

struct RouteModel {
    let id: String
    let name: String
    let info: Info
    let date: Date
    let time: String
    let distance: String
    let price: String
    let components: Components
    let buyComponents: BuyComponents
}

extension RouteModel {
    struct Info {
        let startPoint: String
        let destination: String
    }
    
    struct Components {
        let route: String
        let routeCode: String
        let date: Date
        let time: String
    }
    
    struct BuyComponents {
        let name: String
        let url: URL?
    }
}

extension RouteModel: SelectIdentifiable {}
