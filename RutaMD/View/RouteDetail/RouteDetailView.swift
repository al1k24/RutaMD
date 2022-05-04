//
//  RouteDetailView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import SwiftUI

struct RouteDetailView: View {
    private let route: RouteModel
    
    init(route: RouteModel) {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        self.route = route
    }
    
    var body: some View {
        VStack {
            Text("ID: \(route.id)")
            Text("NAME: \(route.name)")
            Text("DATE: \(route.date)")
            Text("DISTANCE: \(route.distance)")
        }
        .background(Color.Theme.background)
        .navigationBarTitle("Ruta #\(route.id)", displayMode: .inline)
    }
}

struct RouteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
