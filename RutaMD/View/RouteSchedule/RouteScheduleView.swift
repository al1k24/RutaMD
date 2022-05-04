//
//  RouteScheduleView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct RouteScheduleView: View {
    @ObservedObject private var viewModel: RouteScheduleViewModel
    
    @State private var selectedRoute: RouteModel?
    
    init(viewModel: RouteScheduleViewModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.viewModel = viewModel
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
                .listStyle(.plain)
                .background(Color.Theme.background)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .navigationBarTitle("Rutele", displayMode: .inline)
    }
    
    @ViewBuilder
    private func destinationView(route: RouteModel) -> some View {
        LazyView(RouteDetailView(route: route))
//            .environmentObject(routeViewModel)
    }
}

struct RouteScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
