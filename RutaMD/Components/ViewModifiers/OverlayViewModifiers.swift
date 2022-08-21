//
//  OverlayViewModifiers.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.08.2022.
//

import SwiftUI

enum OverlayType {
    case circle
    case roundedRectangle(cornerRadius: CGFloat)
}

fileprivate struct OverlayWithCircleViewModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
            )
    }
}

fileprivate struct OverlayWithRoundedRectangleModifiers: ViewModifier {
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.hexF2F2F2_393F4D, lineWidth: 2)
            )
    }
}

extension View {
    
    @ViewBuilder
    func overlay(with type: OverlayType) -> some View {
        switch type {
        case .circle:
            self.modifier(OverlayWithCircleViewModifiers())
        case .roundedRectangle(let cornerRadius):
            self.modifier(OverlayWithRoundedRectangleModifiers(cornerRadius: cornerRadius))
        }
    }
}
