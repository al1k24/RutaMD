//
//  RouteDetailPlacesView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 15.05.2022.
//

import SwiftUI

struct RouteDetailPlacesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: RouteDetailPlacesViewModel
    
    private let gridItemLayout: [GridItem] = [
        GridItem(.fixed(60), spacing: 32, alignment: .center),
        GridItem(.fixed(60), spacing: 32, alignment: .center),
        GridItem(.fixed(60), spacing: 32, alignment: .center)
    ]
    
    init(viewModel: RouteDetailPlacesViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            AsyncContentView(viewModel: viewModel) { (places: [RouteDetailModel.Place]) in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 32) {
                        ForEach(places, id: \.id) { place in
                            Text("\(place.id)")
                                .frame(width: 60, height: 60, alignment: .center)
                                .background((place.isAvailable ? Color.hex1BAA1A : Color.hexFF364F).opacity(0.2))
                                .foregroundColor(Color.Theme.Text.secondary)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.hexF2F2F2_393F4D, lineWidth: 2))
                        }
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                }
            }
            .background(Color.Theme.background)
            .navigationBarTitle("available_seats", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("сlose") {
                        dismiss()
                    }
                }
            }
        }
    }
}
