//
//  NavigationLinkModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 04.05.2022.
//

import SwiftUI

fileprivate struct NavigationLinkModifier<Destination: View>: ViewModifier {
    @ViewBuilder var destination: () -> Destination

    func body(content: Content) -> some View {
        content
            .background(content: backgroundView)
    }
    
    private func backgroundView() -> some View {
        NavigationLink(destination: self.destination) {
            EmptyView()
        }
        .opacity(0)
    }
}

fileprivate struct NavigationLinkModifier2<Destination: View>: ViewModifier {
    @Binding var isActive: Bool
    @ViewBuilder var destination: () -> Destination

    func body(content: Content) -> some View {
        content
            .background(content: backgroundView)
    }
    
    private func backgroundView() -> some View {
        NavigationLink(isActive: $isActive, destination: self.destination) {
            EmptyView()
        }
        .opacity(0)
    }
}

extension View {
    func navigationLink<Destination: View>(_ destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier(destination: destination))
    }
    
    func navigationLink<Destination: View>(isActive: Binding<Bool>, _ destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier2(isActive: isActive, destination: destination))
    }
}
