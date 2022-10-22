//
//  SectionView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 22.05.2022.
//

import SwiftUI

struct SectionView<Content: View>: View {
    private let title: LocalizedStringKey
    private let content: Content

    init(_ title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .padding(.vertical, 8)
            
            content
                .padding(16)
                .background(Color.hexFFFFFF_232730)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.hexF2F2F2_393F4D, lineWidth: 1)
                )
        }
        .padding(.horizontal, 16)
    }
}
