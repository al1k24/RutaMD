//
//  HomeSearchButtonView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 22.05.2022.
//

import SwiftUI

struct HomeSearchButtonView<Content: View, Destination: View>: View {
    private let isValid: Bool
    private let action: () -> Void
    
    private let content: Content
    private let destination: Destination
    
    init(isValid: Bool, action: @escaping () -> Void, destination: () -> Destination, @ViewBuilder content: () -> Content) {
        self.isValid = isValid
        self.action = action
        
        self.content = content()
        self.destination = destination()
    }
    
    var body: some View {
        if isValid {
            NavigationLink(destination: destination) {
                content
            }
        } else {
            Button(action: action) {
                content
            }
        }
    }
}
