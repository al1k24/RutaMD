//
//  SelectView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 20.04.2022.
//

import SwiftUI

struct SelectView<Source: LoadableObject, Entity: SelectIdentifiable>: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var source: Source
    @Binding private var onSelect: Entity?
    
    private let title: String
    
    init(source: Source, onSelect: Binding<Entity?>, title: String) {
        print("[\(Date().formatted(date: .omitted, time: .shortened))] \(Self.self): \(#function)")
        
        self.title = title
        self.source = source
        self._onSelect = onSelect
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 0) {
                Text(title)
            }
            .frame(height: 56)
            
            AsyncContentView(source: source) { output in
                let entities = output as? [Entity] ?? []
                
                List(entities, id: \.id) { entity in
                    Button {
                        onSelect = entity
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("\(entity.name) -> id: \(entity.id)")
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .leading)
        }
    }
}

struct SelectStationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
