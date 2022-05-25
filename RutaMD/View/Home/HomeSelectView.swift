//
//  HomeSelectView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 20.04.2022.
//

import SwiftUI

struct HomeSelectView<ViewModel: LoadableObject, Entity: SelectIdentifiable>: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: ViewModel
    @Binding private var onSelect: Entity?
    
    init(viewModel: ViewModel, onSelect: Binding<Entity?>) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self._viewModel = .init(wrappedValue: viewModel)
        self._onSelect = onSelect
    }
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) { output in
            let entities = output as? [Entity] ?? []
            
            List(entities, id: \.id) { entity in
                Button {
                    if onSelect?.id != entity.id {
                        onSelect = entity
                    }
                    
                    dismiss()
                } label: {
                    Text("\(entity.name) -> id: \(entity.id)")
                }
            }
        }
    }
}

struct SelectStationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
