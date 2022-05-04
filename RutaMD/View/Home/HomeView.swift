//
//  HomeView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var routeViewModel = RouteViewModel()
    
    @State private var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    init() { print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)") }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HomeHeaderView()
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        Text("Ultimele rute")
                    } header: {
                        HomePinnedHeaderView()
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(HomeOffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(HomeOffsetModifier(offset: $headerOffsets.1))
                    }
                }
                .offset(y: -90)
            }
        }
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
        .background(Color.Theme.background)
        .environmentObject(routeViewModel)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
