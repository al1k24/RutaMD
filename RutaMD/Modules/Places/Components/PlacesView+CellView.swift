//
//  PlacesView+CellView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.08.2022.
//

import SwiftUI

extension PlacesView {
    struct CellView: View {
        private let place: RouteDetailModel.Place
        
        init(place: RouteDetailModel.Place) {
            self.place = place
        }
        
        var body: some View {
            Text(place.id.toString())
                .frame(width: 60, height: 60, alignment: .center)
                .background((place.isAvailable ? Color.hex1BAA1A : Color.hexFF364F).opacity(0.2))
                .foregroundColor(Color.Theme.Text.secondary)
                .overlay(with: .circle)
        }
    }
}
