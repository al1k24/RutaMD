//
//  RouteScheduleView+CellView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 04.05.2022.
//

import SwiftUI

extension RouteScheduleView {
    struct CellView: View {
        private let routeModel: RouteModel
        
        @Binding private var selectedURL: URL?
        
        init(routeModel: RouteModel, selectedURL: Binding<URL?>) {
            self.routeModel = routeModel
            self._selectedURL = selectedURL
        }
        
        var body: some View {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    headerView()
                    SeparatorView()
                    footerView()
                }
                
                availabilityView()
            }
            .foregroundColor(Color.Theme.Text.secondary)
            .background(Color.hexFFFFFF_232730)
            .overlay(with: .roundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        
        private func headerView() -> some View {
            VStack(alignment: .leading, spacing: 0) {
                routeStartPointView()
                routeDestinationView()
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        private func routeStartPointView() -> some View {
            HStack(alignment: .top, spacing: 16) {
                VStack(spacing: 0) {
                    Image(systemName: "circle.circle")
                    
                    Line(startPoint: .top, endPoint: .bottom)
                        .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                        .frame(width: 14)
                }
                
                HStack(alignment: .top, spacing: 4) {
                    Text(routeModel.info.startPoint)
                    
                    Spacer()
                    
                    routeTimeView()
                }
                .padding(.bottom, 16)
            }
        }
        
        private func routeDestinationView() -> some View {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: "circle.circle")
                Text(routeModel.info.destination)
            }
        }
        
        private func routeTimeView() -> some View {
            HStack(spacing: 2) {
                Image(systemName: "bus.fill")
                Text(routeModel.time)
            }
        }
        
        private func footerView() -> some View {
            HStack(spacing: 0) {
                Text(routeModel.price)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.hexF2F2F2_393F4D, lineWidth: 1)
                    )
                    .padding(.leading, 26)
                
                Spacer()
                
                Button(action: {
                    selectedURL = routeModel.buyComponents.url
                    UIDevice.vibrate(.soft)
                }) {
                    Image(systemName: routeModel.buyComponents.url != nil ? "cart.badge.plus" : "cart.badge.minus")
                        .resizable()
                        .scaledToFill()
                        .padding()
                        .frame(width: 56, height: 56)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 12)
                .foregroundColor(routeModel.buyComponents.url == nil ? Color.hexFF364F : Color.hex1BAA1A)
            }
        }
        
        private func availabilityView() -> some View {
            Rectangle()
                .fill(routeModel.buyComponents.url == nil ? Color.hexFF364F : Color.hex1BAA1A)
                .frame(width: 3, height: 24, alignment: .leading)
                .cornerRadius(4, corners: [.topRight, .bottomRight])
                .offset(y: 24)
        }
    }
}
