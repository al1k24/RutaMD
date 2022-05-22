//
//  RouteScheduleView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct RouteScheduleView: View {
    @StateObject private var viewModel: RouteScheduleViewModel
    
    init(viewModel: RouteScheduleViewModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RouteScheduleHeaderView(viewModel: viewModel)
            
            AsyncContentView(viewModel: viewModel) { (routes: [RouteModel]) in
                List(routes, id: \.id) { entity in
                    RouteScheduleItemView(routeModel: entity)
                    .navigationLink({ destinationView(route: entity) })
                    .listRow()
                }
                .listStyle()
            }
        }
        .navigationBarTitle("Rutele", displayMode: .inline)
    }
    
    @ViewBuilder
    private func destinationView(route: RouteModel) -> some View {
        LazyView(RouteDetailView(viewModel: .init(route: route)))
//            .environmentObject(routeViewModel)
    }
}

struct RouteScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
