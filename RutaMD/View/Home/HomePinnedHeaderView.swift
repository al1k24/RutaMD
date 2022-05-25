//
//  HomePinnedHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct HomePinnedHeaderView: View {
    @EnvironmentObject private var routeViewModel: RouteViewModel
    
    private enum ActiveSheet: Identifiable {
        case configure, selectStartPoint, selectStation, selectDate
        
        var id: Int {
            return hashValue
        }
    }
    
    @State private var activeSheet: ActiveSheet?
    
//    init() { print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)") }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                buttonView(title: routeViewModel.startPoint?.name ?? "De unde",
                           icon: routeViewModel.startPoint == nil ? "circle.circle" : "circle.circle.fill") {
                    activeSheet = .selectStartPoint
                }
                
                SeparatorView()
                
                buttonView(title: routeViewModel.station?.name ?? "Direcție",
                           icon: routeViewModel.station == nil ? "circle.circle" : "circle.circle.fill") {
                    activeSheet = routeViewModel.startPoint == nil ? .configure : .selectStation
                }
                
                SeparatorView()
                
                buttonView(title: routeViewModel.date?.name ?? "Data",
                           icon: routeViewModel.date == nil ? "calendar.badge.plus" : "calendar") {
                    activeSheet = routeViewModel.station == nil ? .configure : .selectDate
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            HomeSearchButtonView(isValid: routeViewModel.isValidSearch(),
                                 action: { activeSheet = .configure },
                                 destination: { destinationView() }) {
                Text("GĂSEȘTE RUTE")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.hexFFFFFF)
                    .frame(maxWidth: .infinity, idealHeight: 56, alignment: .center)
            }
            .background(Color.hex3C71FF)
        }
        .background(Color.Theme.background)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
        )
        .padding(.horizontal, 32)
        .sheet(item: $activeSheet, content: handleActionSheet)
        .navigationLink(isActive: $routeViewModel.isActiveQuickSearch, { destinationView() })
    }
    
    @ViewBuilder
    private func handleActionSheet(_ item: ActiveSheet) -> some View {
        switch item {
        case .selectStartPoint:
            HomeSelectView(viewModel: SelectStartPointViewModel(startPoints: routeViewModel.startPoints),
                           onSelect: $routeViewModel.startPoint)
        case .selectStation:
            HomeSelectView(viewModel: SelectStationViewModel(startPoint: routeViewModel.startPoint,
                                                             stations: $routeViewModel.stations),
                           onSelect: $routeViewModel.station)
        case .selectDate:
            HomeSelectView(viewModel: SelectDateViewModel(startPoint: routeViewModel.startPoint,
                                                      station: routeViewModel.station,
                                                      dates: $routeViewModel.dates),
                           onSelect: $routeViewModel.date)
        case .configure:
            HomeSearchView()
        }
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        LazyView(RouteScheduleView(viewModel: .init(startPoint: routeViewModel.startPoint,
                                                    station: routeViewModel.station,
                                                    date: routeViewModel.date)))
        .environmentObject(routeViewModel)
    }
    
    @ViewBuilder
    private func buttonView(title: String, icon: String, action: @escaping (() -> Void)) -> some View {
        Button(action: action) {
            Label(title, systemImage: icon)
            .frame(maxWidth: .infinity, idealHeight: 36, alignment: .leading)
        }
        .foregroundColor(Color.Theme.Text.secondary)
    }
}

struct HomePinnedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
