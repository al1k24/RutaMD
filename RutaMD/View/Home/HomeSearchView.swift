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
    
    init() {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    SectionView(title: "Locația") {
                        selectStartPointView()
                    }
                    
                    SectionView(title: "Direcția") {
                        selectStationView()
                    }
                    
                    SectionView(title: "Data") {
                        selectDateView()
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
            }
        }
    }
    
    private func selectStartPointView() -> some View {
        NavigationLink(destination: {
            LazyView(SelectView(viewModel: SelectStartPointViewModel(startPoints: routeViewModel.startPoints),
                                onSelect: $routeViewModel.startPoint))
            .navigationBarTitle("Alege locația", displayMode: .inline)
        }) {
            sectionItem(title: routeViewModel.startPoint?.name, placeholder: "Alege locația")
        }
    }
    
    private func selectStationView() -> some View {
        NavigationLink(destination: {
            LazyView(SelectView(viewModel: SelectStationViewModel(startPoint: routeViewModel.startPoint,
                                                                  stations: $routeViewModel.stations),
                                onSelect: $routeViewModel.station))
            .navigationBarTitle("Alege direcția", displayMode: .inline)
        }) {
            sectionItem(title: routeViewModel.station?.name, placeholder: "Alege direcția")
        }
    }
    
    private func selectDateView() -> some View {
        NavigationLink(destination: {
            LazyView(SelectView(viewModel: SelectDateViewModel(startPoint: routeViewModel.startPoint,
                                                               station: routeViewModel.station,
                                                               dates: $routeViewModel.dates),
                                onSelect: $routeViewModel.date))
            .navigationBarTitle("Alege data", displayMode: .inline)
        }) {
            sectionItem(title: routeViewModel.date?.name, placeholder: "Alege data")
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
