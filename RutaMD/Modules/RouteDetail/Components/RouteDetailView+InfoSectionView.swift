//
//  RouteDetailView+InfoSectionView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import SwiftUI

extension RouteDetailView {
    struct InfoSectionView: View {
        private let startPointName: String
        private let stationName: String
        private let action: () -> Void
        
        init(startPointName: String, stationName: String, action: @escaping () -> Void) {
            self.startPointName = startPointName
            self.stationName = stationName
            
            self.action = action
        }
        
        var body: some View {
            Section {
                HStack(alignment: .center, spacing: 16) {
                    InfoView(title: "from", subtitle: startPointName, alignment: .leading)
                    InfoView(title: "to", subtitle: stationName, alignment: .trailing)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .overlay(content: busView)
            }
        }
        
        private func busView() -> some View {
            Button(action: action) {
                Image(systemName: "bus.fill")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding(12)
                    .background(Color.Theme.background)
                    .overlay(with: .circle)
            }
            .buttonStyle(.plain)
            .foregroundColor(Color.hex3C71FF)
        }
    }
}
