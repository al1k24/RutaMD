//
//  RouteView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct RouteView: View {
    @StateObject private var viewModel = RouteViewModel()
    
    @State private var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                LogoView()
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        Text("last_routes")
                    } header: {
                        HeaderView()
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
        .environmentObject(viewModel)
    }
}
