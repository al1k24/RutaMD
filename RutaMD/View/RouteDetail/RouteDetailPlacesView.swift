//
//  RouteDetailPlacesView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 15.05.2022.
//

import SwiftUI

struct RouteDetailPlacesView: View {
    private(set) var places: [RouteDetailModel.Place] = [
        .init(id: 1, isAvailable: false),
        .init(id: 2, isAvailable: true),
        .init(id: 3, isAvailable: true),
        .init(id: 4, isAvailable: false),
        .init(id: 5, isAvailable: true),
        .init(id: 6, isAvailable: true),
        .init(id: 7, isAvailable: true),
        .init(id: 8, isAvailable: true),
        .init(id: 9, isAvailable: true),
        .init(id: 10, isAvailable: true),
        .init(id: 11, isAvailable: true),
        .init(id: 12, isAvailable: false),
        .init(id: 13, isAvailable: true),
        .init(id: 14, isAvailable: true)
    ]
    
    private let gridItemLayout: [GridItem] = [
        GridItem(.fixed(60), spacing: 32, alignment: .center),
        GridItem(.fixed(60), spacing: 32, alignment: .center),
        GridItem(.fixed(60), spacing: 32, alignment: .center)
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Locuri disponibile")
                .frame(height: 44)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 32) {
                    ForEach(places, id: \.id) { place in
                        Text("\(place.id)")
                            .frame(width: 60, height: 60, alignment: .center)
                            .background((place.isAvailable ? Color.hex1BAA1A : Color.hexFF364F).opacity(0.2))
                            .foregroundColor(Color.Theme.Text.secondary)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.hexF2F2F2_393F4D, lineWidth: 2))
                    }
                }
                .padding(.top, 8)
            }
        }
        .background(Color.Theme.background)
    }
}

struct RouteDetailPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailPlacesView()
            .preferredColorScheme(.dark)
            .padding(.vertical, 16)
            .background(Color.Theme.background)
    }
}
