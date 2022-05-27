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
                    Section {
                        
                    }
                    .listRow()
                    .background(.yellow.opacity(0.3))
                    
                    Section(content: { contentView(routeDetail: routeDetail) },
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
            if let url = viewModel.route.buyComponents.url {
                SFSafariView(url: url)
            } else {
                // TODO: Display Error View
                Text("[Error]: Invalid URL")
            }
        }
    }
    
    @ViewBuilder
    private func contentView(routeDetail: RouteDetailModel) -> some View {
        hLineView()
        
        VStack(alignment: .leading, spacing: 0) {
            headerView()
            
            let lastStationId = routeDetail.stations.last?.id
            ForEach(routeDetail.stations, id: \.id) {
                RouteDetailItemView(station: $0, isLast: $0.id == lastStationId)
            }
        }
    }
    
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: 24) {
            Text("Pornire")
                .frame(width: 112)
            
            Text("Informatie")
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .background(Color.Theme.background)
        .foregroundColor(Color.Theme.Text.secondary)
    }
    
    private func footerView() -> some View {
        buyButtonView()
            .padding(.vertical, 16)
    }
    
    private func buyButtonView() -> some View {
        Button(action: { activeSheet = .buy }) {
            Label(viewModel.route.price, systemImage: "cart")
                .font(.headline.bold())
        }
        .frame(maxWidth: .infinity, idealHeight: 56, maxHeight: 56, alignment: .center)
        .foregroundColor(Color.hexFFFFFF)
        .background(Color.hex3C71FF)
        .cornerRadius(16)
        .padding(.horizontal, 32)
    }
    
    private func hLineView() -> some View {
        Line(startPoint: .leading, endPoint: .trailing)
            .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, idealHeight: 4, maxHeight: 4, alignment: .bottom)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
