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
            HomeView()
                .navigationView()
                .tab(.home)
            
            TestView()
                .navigationView()
                .tab(.test)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
