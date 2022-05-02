//
//  RouteScheduleView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct RouteScheduleView: View {
    @ObservedObject private var source: RouteScheduleViewModel
    
    init(source: RouteScheduleViewModel) {
        print("[\(Date())] \(Self.self): \(#function)")
        
        self.source = source
    }
    
    var body: some View {
        AsyncContentView(source: source) { output in
            let routes = output as [RouteModel]
            
            List(routes, id: \.id) { entity in
                Button {
//                    onSelect = entity
//                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("\(entity.name) -> id: \(entity.id)")
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.Custom.background)
            }
            .listStyle(.plain)
            .background(Color.Custom.background)
        }
    }
}

struct RouteScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
