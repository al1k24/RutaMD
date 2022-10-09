//
//  StationLocationsView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import SwiftUI

struct StationLocationsView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(systemName: "bus.fill")
                .resizable()
                .frame(width: 25, height: 25, alignment: .center)
                .padding(12)
                .background(Color.Theme.background)
                .overlay(with: .circle)
                .foregroundColor(Color.hex3C71FF)
                .offset(x: 4)
                .zIndex(1)

            Text("location.name")
                .fixedSize()
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.Theme.background)
                .cornerRadius(8, corners: [.topRight, .bottomRight])
        }
    }
}

struct StationLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationLocationsView()
    }
}
