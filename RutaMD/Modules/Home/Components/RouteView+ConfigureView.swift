//
//  RouteView+ConfigureView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import SwiftUI
import SwiftUIKit

extension RouteView {
    struct ConfigureView: View {
        @Environment(\.dismiss) private var dismiss
        @EnvironmentObject private var routeViewModel: RouteViewModel
        
        private enum DestinationType {
            case startPoint, station, date
            
            var title: String {
                switch self {
                case .startPoint: return "choose_the_location"
                case .station: return "choose_the_direction"
                case .date: return "choose_a_date"
                }
            }
        }
        
        var body: some View {
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        SectionView("location") {
                            selectView(.startPoint, title: routeViewModel.startPoint?.name)
                        }
                        
                        SectionView("direction") {
                            selectView(.station, title: routeViewModel.station?.name)
                        }
                        
                        SectionView("date") {
                            selectView(.date, title: routeViewModel.date?.name)
                        }
                    }
                    .padding(.bottom, 16)
                }
                .background(Color.Theme.background)
                .foregroundColor(Color.Theme.Text.secondary)
                .navigationBarTitle("configuration", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("search") {
                            dismiss()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.routeViewModel.isActiveQuickSearch.toggle()
                            }
                        }
                        .disabled(!routeViewModel.isValidSearch)
                    }
                }
            }
        }
        
        private func selectView(_ type: DestinationType, title: String?) -> some View {
            NavigationLink(destination: {
                LazyView(destinationView(type))
                    .navigationBarTitle(LocalizedStringKey(type.title), displayMode: .inline)
            }) { sectionItem(title: title, placeholder: type.title) }
        }
        
        @ViewBuilder
        private func destinationView(_ type: DestinationType) -> some View {
            switch type {
            case .startPoint:
                SelectView(viewModel: SelectStartPointViewModel(startPoints: routeViewModel.startPoints),
                               selectedEntity: routeViewModel.startPoint,
                               navigationView: false,
                               onSelect: $routeViewModel.startPoint)
            case .station:
                SelectView(viewModel: SelectStationViewModel(startPoint: routeViewModel.startPoint,
                                                                 stations: $routeViewModel.stations),
                               selectedEntity: routeViewModel.station,
                               navigationView: false,
                               onSelect: $routeViewModel.station)
            case .date:
                SelectView(viewModel: SelectDateViewModel(startPoint: routeViewModel.startPoint,
                                                          station: routeViewModel.station,
                                                          dates: $routeViewModel.dates),
                               selectedEntity: routeViewModel.date, navigationView: false,
                               onSelect: $routeViewModel.date)
            }
        }
        
        @ViewBuilder
        private func sectionItem(title: String?, placeholder: String) -> some View {
            HStack(alignment: .center, spacing: 4) {
                Text(title, placeholder: placeholder)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(title == nil ? Color.Theme.Text.secondary : Color.Theme.Text.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
        }
    }
}
