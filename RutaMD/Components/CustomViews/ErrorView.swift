//
//  ErrorView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.08.2022.
//

import SwiftUI

struct ErrorView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private var backgroundColor: Color {
        return (colorScheme == .dark ? Color.white : Color.black).opacity(0.1)
    }
    
    private let title: String
    private let message: String
    private let action: () -> Void
    
    init(title: String, message: String, button: (() -> Button<Text>)? = nil, action: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.action = action
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.clear
            
            VStack(alignment: .center, spacing: 0) {
                Image(systemName: "bus.fill")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(12)
                    .background()
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.yellow, lineWidth: 4)
                    )
                    .foregroundColor(Color.hex3C71FF)
                    .zIndex(1)
                
                VStack(alignment: .center, spacing: 8) {
                    Text(title)
                        .padding(.top, 38)
                    
                    Text(message)
                        .padding(.bottom, 16)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.yellow.cornerRadius(18))
                .padding(.top, -24)
                .padding(.horizontal, 48)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Error", message: "Test message", action: {})
    }
}
