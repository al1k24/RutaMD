//
//  ListStyleModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 15.05.2022.
//

import SwiftUI

struct ListStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .background(Color.Theme.background)
    }
}

extension View {
    
    /// List with custom style
    func listStyle() -> some View {
        self.modifier(ListStyleModifier())
    }
}
