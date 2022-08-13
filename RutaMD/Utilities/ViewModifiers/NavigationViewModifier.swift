//
//  NavigationViewModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

struct NavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        NavigationView {
            content
                .navigationBarHidden(true)
        }
        .onAppear {
            navigationBarColors(background: UIColor(named: "background"),
                                titleColor: UIColor(named: "hex3C71FF"),
                                tintColor: UIColor(named: "hex3C71FF"))
        }
    }
    
    private func navigationBarColors(background : UIColor?, titleColor : UIColor? = nil, tintColor : UIColor? = nil) {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithTransparentBackground()
//        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear

        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]

        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance

        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .blue
    }
}

struct CustomNavigationViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    private let title: String
    private let isEnabled: Bool
    
    init(title: String, isEnabled: Bool) {
        self.title = title
        self.isEnabled = isEnabled
    }
    
    func body(content: Content) -> some View {
        if isEnabled {
            NavigationView {
                content
                    .navigationBarTitle(LocalizedStringKey(title), displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("сlose") {
                                dismiss()
                            }
                        }
                    }
            }
        } else {
            content
        }
    }
}

extension View {
    func navigationView() -> some View {
        self.modifier(NavigationViewModifier())
    }
    
    func navigationView(title: String, isEnabled: Bool) -> some View {
        self.modifier(CustomNavigationViewModifier(title: title, isEnabled: isEnabled))
    }
}
