//
//  RouteDetailView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import SwiftUI

struct RouteDetailView: View {
    @StateObject private var viewModel: RouteDetailViewModel
    
    @State private var isPresentedPlaces: Bool = false
    
    init(viewModel: RouteDetailViewModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) { (routeDetail: RouteDetailModel) in
            List {
                Section(content: { contentView(routeDetail: routeDetail) },
                        header: headerView,
                        footer: footerView)
                .listRow()
            }
            .listStyle()
        }
        .navigationBarTitle(viewModel.getTitle(), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isPresentedPlaces.toggle() }) {
                    Image(systemName: "person.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .foregroundColor(Color.hex3C71FF)
            }
        }
        .sheet(isPresented: $isPresentedPlaces) {
            RouteDetailPlacesView()
        }
    }
    
    @ViewBuilder
    private func contentView(routeDetail: RouteDetailModel) -> some View {
        let lastStationId = routeDetail.stations.last?.id
        
        ForEach(routeDetail.stations, id: \.id) { station in
            RouteDetailItemView(station: station, isLast: station.id == lastStationId)
        }
    }
    
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: 32) {
            Text("Pornire")
                .frame(width: 92)
            
            
            Text("Informatie")
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
        .background(Color.Theme.background)
        .foregroundColor(Color.Theme.Text.secondary)
    }
    
    private func footerView() -> some View {
        Label("Pretul si distanta se calculeaza de la punctul de pornire !", systemImage: "info.circle")
            .padding(16)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
