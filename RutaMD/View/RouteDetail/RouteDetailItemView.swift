//
//  RouteDetailItemView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.05.2022.
//

import SwiftUI

struct RouteDetailItemView: View {
    
    private let station: RouteDetailModel.Station
    private let isLastItem: Bool
    
    init(station: RouteDetailModel.Station, isLast: Bool = false) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.station = station
        self.isLastItem = isLast
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .center, spacing: 2) {
                Text(station.date.toDisplay(format: "dd MMM"))
                Text(station.time ?? "-")
            }
            .frame(width: 80, alignment: .top)
            
            VStack(spacing: 0) {
                Image(systemName: "circle.circle")
                
                if !isLastItem {
                    Line(startPoint: .top, endPoint: .bottom)
                        .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                }
            }
            .frame(width: 10, alignment: .center)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(station.name)
                
                if station.price != "0" {
                    infoView("\(station.distance) km", icon: "mappin.circle")
                    infoView(station.price, icon: "cart.circle")
                }
            }
            .padding(.bottom, 16)
        }
        .foregroundColor(Color.Theme.Text.secondary)
//        .padding(.leading, 16)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func infoView(_ text: String, icon: String) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
        }
    }
}

struct RouteDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
