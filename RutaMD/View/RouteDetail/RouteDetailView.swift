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
                        Section {
                            HStack(alignment: .center, spacing: 16) {
                                routeInformationView(title: "from",
                                                     subtitle: routeViewModel.startPoint?.name ?? "",
                                                     alignment: .leading)
                                
                                routeInformationView(title: "to",
                                                      subtitle: routeViewModel.station?.name ?? "",
                                                      alignment: .trailing)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .overlay(content: { busView(proxy: proxy) })
                        }
                        .listRow()
                        
                        Section(content: { contentView(routeDetail: routeDetail) },
                                footer: footerView)
                        .listRow()
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
        .sheet(item: $activeSheet, content: handleActionSheet)
    }
    
    @ViewBuilder
    private func toolbarButton(_ type: ActiveSheet) -> some View {
        Button(action: {
            activeSheet = type
            UIDevice.vibrate(.soft)
        }) {
            Image(systemName: type.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
        }
    }
    
    @ViewBuilder
    private func handleActionSheet(_ item: ActiveSheet) -> some View {
        switch item {
        case .places:
            RouteDetailPlacesView(viewModel: .init(startPoint: routeViewModel.startPoint,
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
    
    @ViewBuilder
    private func contentView(routeDetail: RouteDetailModel) -> some View {
        headerView()
        
        let lastStationId = routeDetail.stations.last?.id
        ForEach(routeDetail.stations, id: \.id) {
            RouteDetailItemView(station: $0, isLast: $0.id == lastStationId)
        }
    }
    
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: 24) {
            Text(LocalizedStringKey("leaving"))
                .frame(width: 112)
            
            Text(LocalizedStringKey("information"))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
        .background(Color.Theme.background)
        .foregroundColor(Color.Theme.Text.secondary)
    }
    
    @ViewBuilder
    private func footerView() -> some View {
        if viewModel.route.buyComponents.url != nil {
            buyButtonView()
                .padding(.vertical, 16)
        }
    }
    
    private func buyButtonView() -> some View {
        Button(action: {
            activeSheet = .buy
            UIDevice.vibrate(.soft)
        }) {
            Label(viewModel.route.price, systemImage: "cart")
                .font(.headline.bold())
        }
        .id("bottomBuyButton")
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
    
    private func routeInformationView(title: String, subtitle: String, alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 4) {
            Text(LocalizedStringKey(title))
                .font(.system(size: 12))
            
            Text(subtitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: 72, alignment: alignment == .leading ? .topLeading : .topTrailing)
        .padding(16)
        .if(alignment == .leading) {
            $0.padding(.trailing, 8)
        }
        .if(alignment == .trailing) {
            $0.padding(.leading, 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
        )
        .foregroundColor(Color.Theme.Text.secondary)
    }
    
    private func busView(proxy: ScrollViewProxy) -> some View {
        Button(action: {
            withAnimation {
                proxy.scrollTo("bottomBuyButton", anchor: .center)
            }
        }) {
            Image(systemName: "bus.fill")
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .padding(12)
                .background(Color.Theme.background)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
                )
        }
        .buttonStyle(.plain)
        .foregroundColor(Color.hex3C71FF)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
