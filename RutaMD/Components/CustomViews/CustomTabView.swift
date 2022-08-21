//
//  CustomTabView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

enum TabType: String, CaseIterable {
    case map
    case home
    case settings
    
    func getIcon(isFilled: Bool) -> String {
        switch self {
        case .home:
            return isFilled ? "bus" : "bus.fill"
        case .map:
            return isFilled ? "map.fill" : "map"
        case .settings:
            return isFilled ? "gearshape.fill" : "gearshape"
        }
    }
}

struct CustomTabView<Content: View>: View {
    @State private var currentTab: TabType = .home
    
    private var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        UITabBar.appearance().isHidden = true
        
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                self.content
            }
            
            Divider()
                .background(Color.hexFFFFFF_393F4D)
            
            // MARK: Custom Tab Bar
            CustomTabBarView(currentTab: $currentTab)
        }
        .background(Color.Theme.background)
    }
}
