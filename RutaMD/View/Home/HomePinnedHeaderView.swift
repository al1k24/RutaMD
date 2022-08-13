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
    @State private var isReadySearch: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                selectView(title: routeViewModel.startPoint?.name,
                           placeholder: "whence",
                           icon: routeViewModel.startPoint == nil ? "circle.circle" : "circle.circle.fill") {
                    activeSheet = .selectStartPoint
                }
                
                SeparatorView()
                
                selectView(title: routeViewModel.station?.name,
                           placeholder: "direction",
                           icon: routeViewModel.station == nil ? "circle.circle" : "circle.circle.fill") {
                    activeSheet = routeViewModel.startPoint == nil ? .configure : .selectStation
                }
                
                SeparatorView()
                
                selectView(title: routeViewModel.date?.name,
                           placeholder: "date",
                           icon: routeViewModel.date == nil ? "calendar.badge.plus" : "calendar") {
                    activeSheet = routeViewModel.station == nil ? .configure : .selectDate
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            Button(action: handleSearchButtonAction) {
                Text("routes_search")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.hexFFFFFF)
                    .frame(maxWidth: .infinity, idealHeight: 56, alignment: .center)
            }
            .navigationLink(isActive: $isReadySearch) {
                destinationView()
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
        .sheet(item: $activeSheet, content: actionSheetView)
        .navigationLink(isActive: $routeViewModel.isActiveQuickSearch) {
            destinationView()
        }
    }
    
    @ViewBuilder
    private func actionSheetView(_ item: ActiveSheet) -> some View {
        switch item {
        case .selectStartPoint:
            HomeSelectView(viewModel: SelectStartPointViewModel(startPoints: routeViewModel.startPoints),
                           selectedEntity: routeViewModel.startPoint,
                           navigationView: true,
                           onSelect: $routeViewModel.startPoint)
        case .selectStation:
            HomeSelectView(viewModel: SelectStationViewModel(startPoint: routeViewModel.startPoint,
                                                             stations: $routeViewModel.stations),
                           selectedEntity: routeViewModel.station,
                           navigationView: true,
                           onSelect: $routeViewModel.station)
        case .selectDate:
            HomeSelectView(viewModel: SelectDateViewModel(startPoint: routeViewModel.startPoint,
                                                          station: routeViewModel.station,
                                                          dates: $routeViewModel.dates),
                           selectedEntity: routeViewModel.date,
                           navigationView: true,
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
    private func selectView(title: String?, placeholder: String, icon: String, action: @escaping (() -> Void)) -> some View {
        Button(action: { action(); UIDevice.vibrate(.selection) }) {
            Label(title, placeholder: placeholder, systemImage: icon)
                .frame(maxWidth: .infinity, idealHeight: 36, alignment: .leading)
        }
        .foregroundColor(Color.Theme.Text.secondary)
    }
    
    private func handleSearchButtonAction() {
        if !routeViewModel.isValidSearch {
            activeSheet = .configure
        } else {
            isReadySearch.toggle()
        }
        
        UIDevice.vibrate(.soft)
    }
}

struct HomePinnedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
