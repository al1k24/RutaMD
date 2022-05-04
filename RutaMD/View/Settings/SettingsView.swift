//
//  SettingsView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 03.05.2022.
//

import SwiftUI

struct SettingsView: View {
    init() { print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)") }
    
    var body: some View {
        Text("Settings View")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
