//
//  HomeSearchView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 22.05.2022.
//

import SwiftUI

struct HomeSearchView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var routeViewModel: RouteViewModel
    
    private enum DestinationType {
        case startPoint, station, date
        
        var title: String {
            switch self {
            case .startPoint: return "Alege locația"
            case .station: return "Alege direcția"
            case .date: return "Alege data"
            }
        }
    }
    
    init() {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SectionView(title: "Locația") {
                        selectView(.startPoint, title: routeViewModel.startPoint?.name)
                    }
                    
                    SectionView(title: "Direcția") {
                        selectView(.station, title: routeViewModel.station?.name)
                    }
                    
                    SectionView(title: "Data") {
                        selectView(.date, title: routeViewModel.date?.name)
                    }
                }
                .padding(.bottom, 16)
            }
            .background(Color.Theme.background)
            .foregroundColor(Color.Theme.Text.secondary)
            .navigationBarTitle("Configurare", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Search") {
                        dismiss()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.routeViewModel.isActiveQuickSearch.toggle()
                        }
                    }
                    .disabled(!routeViewModel.isValidSearch())
                }
            }
        }
    }
    
    private func selectView(_ type: DestinationType, title: String?) -> some View {
        NavigationLink(destination: {
            LazyView(destinationView(type))
                .navigationBarTitle(type.title, displayMode: .inline)
        }) { sectionItem(title: title, placeholder: type.title) }
    }
    
    @ViewBuilder
    private func destinationView(_ type: DestinationType) -> some View {
        switch type {
        case .startPoint:
            HomeSelectView(viewModel: SelectStartPointViewModel(startPoints: routeViewModel.startPoints),
                           onSelect: $routeViewModel.startPoint)
        case .station:
            HomeSelectView(viewModel: SelectStationViewModel(startPoint: routeViewModel.startPoint,
                                                             stations: $routeViewModel.stations),
                           onSelect: $routeViewModel.station)
        case .date:
            HomeSelectView(viewModel: SelectDateViewModel(startPoint: routeViewModel.startPoint,
                                                      station: routeViewModel.station,
                                                      dates: $routeViewModel.dates),
                           onSelect: $routeViewModel.date)
        }
    }
    
    private func sectionItem(title: String?, placeholder: String) -> some View {
        HStack(alignment: .center, spacing: 4) {
            Text(title ?? placeholder)
                .multilineTextAlignment(.leading)
                .foregroundColor(title == nil ? Color.Theme.Text.secondary : Color.Theme.Text.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
    }
}

struct HoveSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
