//
//  RouteScheduleView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI
import SwiftUIKit

struct RouteScheduleView: View {
    @EnvironmentObject private var routeViewModel: RouteViewModel
    @StateObject private var viewModel: RouteScheduleViewModel
    
    @State private var selectedURL: URL?
    
    init(viewModel: RouteScheduleViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView()
                .environmentObject(viewModel)
            
            AsyncContentView(viewModel: viewModel) { (routes: [RouteModel]) in
                List(routes, id: \.id) { entity in
                    CellView(routeModel: entity, selectedURL: $selectedURL)
                        .navigationLink(destination: { destinationView(route: entity) })
                        .listRow()
                }
                .listStyle()
            }
        }
        .navigationBarTitle("routes", displayMode: .inline)
        .sheet(item: $selectedURL, content: handleBuyActionSheet)
    }
    
    @ViewBuilder
    private func destinationView(route: RouteModel) -> some View {
        LazyView(RouteDetailView(viewModel: .init(route: route)))
            .environmentObject(routeViewModel)
    }
    
    @ViewBuilder
    private func handleBuyActionSheet(_ url: URL) -> some View {
        SFSafariView(url: url)
    }
}
