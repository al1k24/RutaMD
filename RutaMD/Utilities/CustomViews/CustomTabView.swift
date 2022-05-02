//
//  CustomTabView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

enum TabType: String, CaseIterable {
    case home
    case test
    
    var title: String {
        switch self {
        case .home: return "calendar"
        case .test: return "signature"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "calendar"
        case .test: return "text.justify"
        }
    }
}

struct CustomTabView<Content: View>: View {
    @State private var currentTab: TabType = .home
    
    private(set) var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        UITabBar.appearance().isHidden = true
        
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                self.content
            }
            
            // MARK: Custom Tab Bar
            CustomTabBarView(currentTab: $currentTab)
        }
        .background(Color.hexFFFFFF_393F4D)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
