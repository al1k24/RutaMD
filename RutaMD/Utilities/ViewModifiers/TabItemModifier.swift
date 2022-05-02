//
//  TabItemModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct TabItemModifier: ViewModifier {
    let tab: TabType
    
    func body(content: Content) -> some View {
        content
            .tag(tab)
    }
}

extension View {
    func tab(_ tab: TabType) -> some View {
        self.modifier(TabItemModifier(tab: tab))
    }
}
