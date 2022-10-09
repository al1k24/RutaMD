//
//  PlacesView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 15.05.2022.
//

import SwiftUI

struct PlacesView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PlacesViewModel
    
    private let gridItemLayout: [GridItem] = [
        GridItem(.fixed(60), spacing: 32, alignment: .center),
        GridItem(.fixed(60), spacing: 32, alignment: .center),
        GridItem(.fixed(60), spacing: 32, alignment: .center)
    ]
    
    init(viewModel: PlacesViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            AsyncContentView(viewModel: viewModel) { (places: [RouteDetailModel.Place]) in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 32) {
                        ForEach(places, id: \.id) { place in
                            CellView(place: place)
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
