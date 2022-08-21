//
//  RouteDetailItemView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.05.2022.
//

import SwiftUI

extension RouteDetailView {
    struct CellView: View {
        private let station: RouteDetailModel.Station
        private let isLastItem: Bool
        
        init(station: RouteDetailModel.Station, isLast: Bool = false) {
            self.station = station
            self.isLastItem = isLast
        }
        
        var body: some View {
            HStack(alignment: .top, spacing: 4) {
                VStack(spacing: 0) {
                    Image(systemName: "circle.circle")
                    
                    if !isLastItem {
                        Line(startPoint: .top, endPoint: .bottom)
                            .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                    }
                }
                .frame(width: 16, alignment: .center)
                .padding(.horizontal, 4)
                
                HStack(alignment: .top, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(station.name)
                        
                        if station.price != "0" {
                            infoView("\(station.distance) km", icon: "mappin.circle")
                            infoView(station.price, icon: "cart.circle")
                        }
                    }
                    .padding(.bottom, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .center, spacing: 2) {
                        Text(station.date.toDisplay(format: "dd MMM"))
                        Text(station.time ?? "-")
                    }
                    .font(.system(size: 14))
                }
            }
            .foregroundColor(Color.Theme.Text.secondary)
            .padding(.horizontal, 16)
        }
        
        private func infoView(_ text: String, icon: String) -> some View {
            HStack(spacing: 4) {
                Image(systemName: icon)
                Text(text)
            }
        }
    }
}

struct RouteDetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 0) {
            RouteDetailView.CellView(station: .init(id: 1, name: "12321 asd asd asd asdas dasd asd asd asdasd asd asdas d", date: Date(), time: "12:12", distance: "12km", price: "1MDL"))
            RouteDetailView.CellView(station: .init(id: 1, name: "12321", date: Date(), time: "12:12", distance: "12km", price: "1MDL"))
        }
    }
}
