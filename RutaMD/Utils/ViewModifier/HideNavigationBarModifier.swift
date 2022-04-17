//
//  HideNavigationBarModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct HideNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

extension View {
    func hideNavigationBar() -> some View {
        self.modifier(HideNavigationBarModifier())
    }
}
