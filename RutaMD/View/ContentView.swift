//
//  ContentView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomTabView {
            TestView()
                .navigationView()
                .tab(.map)
            
            HomeView()
                .navigationView()
                .tab(.home)
            
            SettingsView()
                .navigationView()
                .tab(.settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
