//
//  RouteDetailView+InfoView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import SwiftUI

extension RouteDetailView {
    struct InfoView: View {
        private let title: String
        private let subtitle: String
        private let alignment: HorizontalAlignment
        
        init(title: String, subtitle: String, alignment: HorizontalAlignment) {
            self.title = title
            self.subtitle = subtitle
            self.alignment = alignment
        }
        
        var body: some View {
            VStack(alignment: alignment, spacing: 4) {
                Text(LocalizedStringKey(title))
                    .font(.system(size: 12))
                
                Text(subtitle)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: 72, alignment: alignment == .leading ? .topLeading : .topTrailing)
            .padding(16)
            .if(alignment == .leading) {
                $0.padding(.trailing, 8)
            }
            .if(alignment == .trailing) {
                $0.padding(.leading, 8)
            }
            .overlay(with: .roundedRectangle(cornerRadius: 16))
            .foregroundColor(Color.Theme.Text.secondary)
        }
    }
}
