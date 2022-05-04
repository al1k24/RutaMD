//
//  ListRowModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 04.05.2022.
//

import SwiftUI

struct ListRowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.Theme.background)
    }
}

extension View {
    
    /// List row with custom style
    func listRow() -> some View {
        self.modifier(ListRowModifier())
    }
}
