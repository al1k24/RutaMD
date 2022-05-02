//
//  HomePinnedHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct HomePinnedHeaderView: View {
    @EnvironmentObject private var routeViewModel: RouteViewModel
    
    @State private var year = 2020
    
    private enum ActiveSheet: Identifiable {
        case selectStartPoint, selectStation, selectDate
        
        var id: Int {
            return hashValue
        }
    }
    
    @State private var activeSheet: ActiveSheet?
    
    init() { print("[\(Date())] \(Self.self): \(#function)") }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                buttonView(title: routeViewModel.startPoint?.name, placeholder: "De unde", icon: "circle.circle") {
                    activeSheet = .selectStartPoint
                }
                
                Divider()
                    .background(Color.hexF2F2F2_393F4D)
                
                buttonView(title: routeViewModel.station?.name, placeholder: "Direcție", icon: "circle.circle") {
                    activeSheet = .selectStation
                }
                .disabled(routeViewModel.startPoint == nil)
                
                Divider()
                    .background(Color.hexF2F2F2_393F4D)
                
                buttonView(title: routeViewModel.date?.name, placeholder: "Data", icon: "calendar") {
                    activeSheet = .selectDate
                }
                .disabled(routeViewModel.startPoint == nil || routeViewModel.station == nil)
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            NavigationLink(destination: { LazyView(RouteScheduleView(source: .init(startPoint: routeViewModel.startPoint, station: routeViewModel.station, date: routeViewModel.date))) }) {
                Text("GĂSEȘTE RUTE")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, idealHeight: 56, alignment: .center)
            }
            .background(Color.hex3C71FF)
            .navigationBarTitle("")
            .disabled(routeViewModel.startPoint == nil || routeViewModel.station == nil || routeViewModel.date == nil)
        }
        .background(Color.Custom.background)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
        )
        .padding(.horizontal, 32)
        .sheet(item: $activeSheet, content: handleActionSheet)
    }
    
    @ViewBuilder
    private func handleActionSheet(_ item: ActiveSheet) -> some View {
        switch item {
        case .selectStartPoint:
            SelectView(source: SelectStartPointViewModel(startPoints: routeViewModel.startPoints),
                              onSelect: $routeViewModel.startPoint,
                              title: "Alege locatia")
        case .selectStation:
            SelectView(source: SelectStationViewModel(startPoint: routeViewModel.startPoint,
                                                             stations: $routeViewModel.stations),
                              onSelect: $routeViewModel.station,
                              title: "Alege directia")
        case .selectDate:
            SelectView(source: SelectDateViewModel(startPoint: routeViewModel.startPoint,
                                                   station: routeViewModel.station,
                                                   dates: $routeViewModel.dates),
                       onSelect: $routeViewModel.date,
                       title: "Alege data")
        }
    }
    
    @ViewBuilder
    private func buttonView(title: String?, placeholder: String, icon: String, action: @escaping (() -> Void)) -> some View {
        let isEmptyTitle: Bool = !(title?.isEmpty == false)
        
        Button(action: action) {
            Label(isEmptyTitle ? placeholder : (title ?? ""), systemImage: icon)
            .frame(maxWidth: .infinity, idealHeight: 36, alignment: .leading)
        }
//        .foregroundColor(isEmptyTitle ? .gray : .black)
    }
}

struct HomePinnedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
