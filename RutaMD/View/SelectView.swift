//
//  SelectView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 20.04.2022.
//

import SwiftUI

struct SelectView<ViewModel: LoadableObject, Entity: SelectIdentifiable>: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var viewModel: ViewModel
    @Binding private var onSelect: Entity?
    
    private let title: String
    
    init(viewModel: ViewModel, onSelect: Binding<Entity?>, title: String) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.title = title
        self.viewModel = viewModel
        self._onSelect = onSelect
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .frame(height: 44)
            
            AsyncContentView(viewModel: viewModel) { output in
                let entities = output as? [Entity] ?? []
                
                List(entities, id: \.id) { entity in
                    Button {
                        onSelect = entity
                        dismiss()
                    } label: {
                        Text("\(entity.name) -> id: \(entity.id)")
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .leading)
        }
        .background(Color.Theme.background)
    }
}

struct SelectStationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
