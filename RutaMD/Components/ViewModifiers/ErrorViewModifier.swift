//
//  ErrorViewModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.08.2022.
//

import SwiftUI

fileprivate struct ErrorViewModifier: ViewModifier {
    private let title: String
    private let message: String
    
    @Binding private var isPresenting: Bool
    
    private let completion: (() -> Void)?
    
    init(title: String, message: String, isPresenting: Binding<Bool>, completion: (() -> Void)?) {
        self.title = title
        self.message = message
        
        self._isPresenting = isPresenting
        
        self.completion = completion
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresenting {
                ErrorView(title: title, message: message, action: { isPresenting = false })
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
                    .onDisappear(perform: completion)
            }
        }
        .animation(.spring(), value: isPresenting)
    }
}

extension View {
    func error(_ title: String = "Ooops", message: String, isPresenting: Binding<Bool>, completion: (() -> Void)? = nil) -> some View {
        self.modifier(ErrorViewModifier(title: title, message: message, isPresenting: isPresenting, completion: completion))
    }
}
