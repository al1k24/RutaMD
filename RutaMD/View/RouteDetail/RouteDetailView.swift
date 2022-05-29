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
    }
    
    @State private var activeSheet: ActiveSheet?
    
    init(viewModel: RouteDetailViewModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncContentView(viewModel: viewModel) { (routeDetail: RouteDetailModel) in
                ScrollViewReader { proxy in
                    List {
                        Section {
                            HStack(alignment: .center, spacing: 16) {
                                routeInformationView(title: "Din", subtitle: routeViewModel.startPoint?.name ?? "")
                                routeInformationView2(title: "In", subtitle: routeViewModel.station?.name ?? "")
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
        .navigationBarTitle(viewModel.getTitle(), displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { activeSheet = .buy }) {
                    Image(systemName: "cart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .foregroundColor(Color.hex3C71FF)
                
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
        headerView()
        
        let lastStationId = routeDetail.stations.last?.id
        ForEach(routeDetail.stations, id: \.id) {
            RouteDetailItemView(station: $0, isLast: $0.id == lastStationId)
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
    
    private func routeInformationView(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12))
            
            Text(subtitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: 72, alignment: .topLeading)
        .padding(16)
        .padding(.trailing, 8)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
        )
        .foregroundColor(Color.Theme.Text.secondary)
    }
    
    private func routeInformationView2(title: String, subtitle: String) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(title)
                .font(.system(size: 12))
            
            Text(subtitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: 72, alignment: .topTrailing)
        .padding(16)
        .padding(.leading, 8)
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
