//
//  ResignKeyboardOnDragGestureViewModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 12.06.2022.
//

import SwiftUI

struct ResignKeyboardOnDragGestureViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.highPriorityGesture (
            DragGesture().onChanged { _ in
                UIApplication.shared.endEditing(true)
            }
        )
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGestureViewModifier())
    }
}
