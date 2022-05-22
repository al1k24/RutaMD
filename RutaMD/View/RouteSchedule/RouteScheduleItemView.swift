//
//  RouteScheduleItemView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 04.05.2022.
//

import SwiftUI

// TODO: - Нужно вынести часть кода

struct RouteScheduleItemView: View {
    private let routeModel: RouteModel
    
    init(routeModel: RouteModel) {
//        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.routeModel = routeModel
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
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
        )
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
                dotImageView()
                
                LineShape(startPoint: .top, endPoint: .bottom)
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
            dotImageView()
            
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
            
            buyButtonView()
            .padding(.horizontal, 24)
            .frame(height: 56)
            .foregroundColor(routeModel.buyComponents.url == nil ? Color.hexFF364F : Color.hex1BAA1A)
        }
    }
    
    private func dotImageView() -> some View {
        Image(systemName: "circle.circle")
    }
    
    private func availabilityView() -> some View {
        Rectangle()
            .fill(routeModel.buyComponents.url == nil ? Color.hexFF364F : Color.hex1BAA1A)
            .frame(width: 3, height: 24, alignment: .leading)
            .cornerRadius(4, corners: [.topRight, .bottomRight])
            .offset(y: 24)
    }
    
    @ViewBuilder
    private func buyButtonView() -> some View {
        if let stringURL = routeModel.buyComponents.url?.addBaseURL, let url = URL(string: stringURL) {
            Link(routeModel.buyComponents.name, destination: url)
                .buttonStyle(.plain)
        } else {
            Text(routeModel.buyComponents.name)
        }
    }
}

struct RouteScheduleItemView_Previews: PreviewProvider {
    static var previews: some View {
        RouteScheduleItemView(routeModel: .init(id: "0",
                                                name: "Route 1",
                                                info: .init(startPoint: "Test 1",
                                                            destination: "Test 2"),
                                                date: Date(),
                                                time: "14:30",
                                                distance: "120",
                                                price: "12 MDL",
                                                components: .init(route: "001",
                                                                  routeCode: "0002",
                                                                  date: Date()),
                                                buyComponents: .init(name: "Anulat",
                                                                     url: nil)))
        .frame(height: 192)
    }
}
