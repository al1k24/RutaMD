//
//  ContentView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

enum TabType {
    case home
    case test
    
    var title: String {
        switch self {
        case .home:
            return "calendar"
        case .test:
            return "signature"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "calendar"
        case .test:
            return "text.justify"
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .hideNavigationBar()
                    .tabItem(tab: .home)
                
                TestView()
                    .hideNavigationBar()
                    .tabItem(tab: .test)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
