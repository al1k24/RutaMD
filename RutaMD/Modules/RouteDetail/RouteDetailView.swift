//
//  RouteDetailView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import SwiftUI

struct RouteDetailView: View {
    @EnvironmentObject private var routeViewModel: RouteViewModel
    @StateObject private var viewModel: RouteDetailViewModel
    
    @State private var showingOptions: Bool = false
    
    private enum ActiveSheet: Identifiable {
        case buy, places
        
        var id: Int {
            return hashValue
        }
        
        var icon: String {
            switch self {
            case .buy: return "cart"
            case .places: return "person.2"
            }
        }
    }
    
    @State private var activeSheet: ActiveSheet?
    
    init(viewModel: RouteDetailViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncContentView(viewModel: viewModel) { (routeDetail: RouteDetailModel) in
                ScrollViewReader { proxy in
                    List {
                        InfoSectionView(startPointName: routeViewModel.startPoint?.name ?? "",
                                        stationName: routeViewModel.station?.name ?? "") {
                            handleBussAction(proxy: proxy)
                        }
                        .listRow()
                        
                        StationsSectionView(routeDetail: routeDetail) {
                            handleAction(.buy)
                        }
                        .listRow()
                        .environmentObject(viewModel)
                    }
                    .listStyle()
                }
            }
        }
        .navigationBarTitle(LocalizedStringKey("route_\(viewModel.route.id)"), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                toolbarButton(.buy)
                    .foregroundColor(Color.hex3C71FF.opacity(viewModel.route.buyComponents.url == nil ? 0.5 : 1.0))
                    .disabled(viewModel.route.buyComponents.url == nil)
                
                toolbarButton(.places)
                    .foregroundColor(Color.hex3C71FF)
            }
        }
        .sheet(item: $activeSheet, content: actionSheetView)
    }
    
    @ViewBuilder
    private func toolbarButton(_ type: ActiveSheet) -> some View {
        Button(action: { handleAction(type) }) {
            Image(systemName: type.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
    }
    
    @ViewBuilder
    private func actionSheetView(_ item: ActiveSheet) -> some View {
        switch item {
        case .places:
            PlacesView(viewModel: .init(startPoint: routeViewModel.startPoint,
                                        station: routeViewModel.station,
                                        route: viewModel.route))
        case .buy:
            if let url = viewModel.route.buyComponents.url {
                SFSafariView(url: url)
            } else {
                // TODO: Display Error View
                Text("[Error]: Invalid URL")
            }
        }
    }
    
    private func handleBussAction(proxy: ScrollViewProxy) {
        withAnimation {
            proxy.scrollTo("bottomBuyButton", anchor: .center)
        }
    }
    
    private func handleAction(_ type: ActiveSheet) {
        activeSheet = type
        UIDevice.vibrate(.soft)
    }
}
