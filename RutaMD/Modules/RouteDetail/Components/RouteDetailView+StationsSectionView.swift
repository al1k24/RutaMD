//
//  RouteDetailView+StationsSectionView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import SwiftUI

extension RouteDetailView {
    struct StationsSectionView: View {
        @EnvironmentObject private var viewModel: RouteDetailViewModel
        
        private let routeDetail: RouteDetailModel
        private let lastStationId: Int?
        
        private let action: () -> Void
        
        init(routeDetail: RouteDetailModel, action: @escaping () -> Void) {
            self.routeDetail = routeDetail
            self.lastStationId = routeDetail.stations.last?.id
            
            self.action = action
        }
        
        var body: some View {
            Section(content: contentView, footer: footerView)
        }
        
        @ViewBuilder
        private func contentView() -> some View {
            Text(LocalizedStringKey("all_stations_of_the_route"))
                .fontWeight(.bold)
                .lineLimit(0)
                .padding(.vertical, 16)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.Theme.Text.secondary)
                
            ForEach(routeDetail.stations, id: \.id) {
                CellView(station: $0, isLast: $0.id == lastStationId)
            }
        }
        
        @ViewBuilder
        private func footerView() -> some View {
            if viewModel.route.buyComponents.url != nil {
                Button(action: action) {
                    Label(viewModel.route.price, systemImage: "cart")
                        .font(.headline.bold())
                }
                .id("bottomBuyButton")
                .frame(maxWidth: .infinity, idealHeight: 56, maxHeight: 56, alignment: .center)
                .foregroundColor(Color.hexFFFFFF)
                .background(Color.hex3C71FF)
                .cornerRadius(16)
                .padding(.horizontal, 32)
                .padding(.vertical, 16)
            }
        }
    }
}
