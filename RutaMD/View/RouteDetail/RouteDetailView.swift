//
//  RouteDetailView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import SwiftUI

struct RouteDetailView: View {
    @StateObject private var viewModel: RouteDetailViewModel
    
    private enum ActiveSheet: Identifiable {
        case buy, places
        
        var id: Int {
            return hashValue
        }
    }
    
    @State private var activeSheet: ActiveSheet?
    
    init(viewModel: RouteDetailViewModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncContentView(viewModel: viewModel) { (routeDetail: RouteDetailModel) in
                List {
                    Section(content: { contentView(routeDetail: routeDetail) },
                            header: headerView,
                            footer: footerView)
                    .listRow()
                }
                .listStyle()
            }
        }
        .navigationBarTitle(viewModel.getTitle(), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { activeSheet = .places }) {
                    Image(systemName: "person.2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .foregroundColor(Color.hex3C71FF)
            }
        }
        .sheet(item: $activeSheet, content: handleActionSheet)
    }
    
    @ViewBuilder
    private func handleActionSheet(_ item: ActiveSheet) -> some View {
        switch item {
        case .places:
            RouteDetailPlacesView()
        case .buy:
            if let url = viewModel.getBuyURL() {
                SFSafariView(url: url)
            } else {
                // TODO: Display Error View
                Text("[Error]: Invalid URL")
            }
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
        buyButtonView()
            .padding(.vertical, 16)
    }
    
    private func buyButtonView() -> some View {
        Button(action: { activeSheet = .buy }) {
            Label("Cumpara bilet", systemImage: "cart")
        }
        .frame(maxWidth: .infinity, idealHeight: 56, maxHeight: 56, alignment: .center)
        .background(.red)
        .cornerRadius(16)
        .padding(.horizontal, 32)
        .foregroundColor(Color.Theme.Text.primary)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
