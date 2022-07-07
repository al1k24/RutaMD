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
    
    @State private var searchText = ""
    
    private let navigationView: Bool
    private let selectedEntity: Entity?
    
    init(viewModel: ViewModel, selectedEntity: Entity?, navigationView: Bool, onSelect: Binding<Entity?>) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.navigationView = navigationView
        self.selectedEntity = selectedEntity
        
        self._viewModel = .init(wrappedValue: viewModel)
        self._onSelect = onSelect
    }
    
    var body: some View {
        AsyncContentView(viewModel: viewModel) { output in
            let entities = output as? [Entity] ?? []
            
            VStack(alignment: .leading, spacing: 0) {
                TextField(LocalizedStringKey("search"), text: $searchText)
                    .textFieldStyle(.plain)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 32)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.hexF2F2F2_393F4D, lineWidth: 1)
                            .padding(.horizontal, 16)
                    )
                
                SeparatorView()
                    .padding(.top, 8)
                
                List(getFilteredEntities(from: entities), id: \.id) {
                    cellView($0)
                        .listRow()
                }
                .listStyle()
                .foregroundColor(Color.Theme.Text.secondary)
            }
            .background(Color.Theme.background)
            .resignKeyboardOnDragGesture()
            .navigationView(title: "configuration", isEnabled: navigationView)
        }
    }
    
    private func cellView(_ entity: Entity) -> some View {
        Button(action: { handleButtonAction(entity) }) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 4) {
                    Text(entity.name)
                        .padding(.vertical, 12)
                    
                    Spacer()
                    
                    if selectedEntity?.id == entity.id {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.hex3C71FF)
                    }
                }
                
                SeparatorView()
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func handleButtonAction(_ entity: Entity) {
        if onSelect?.id != entity.id {
            onSelect = entity
        }
        
        dismiss()
    }
    
    private func getFilteredEntities(from source: [Entity]) -> [Entity] {
        return searchText.isEmpty
            ? source
            : source.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
    }
}

struct SelectStationView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
