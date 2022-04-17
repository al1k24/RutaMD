//
//  UIView+Transform.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

extension View {
    
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool,
                               transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(_ condition: Bool,
                                                     if ifTransform: (Self) -> TrueContent,
                                                     else elseTransform: (Self) -> FalseContent) -> some View {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    @ViewBuilder
    func `if`<Transform: View, Item>(`let` item: Item?,
                                     then content: (Self, Item) -> Transform) -> some View {
        if let item = item {
            content(self, item)
        } else {
            self
        }
    }
}
