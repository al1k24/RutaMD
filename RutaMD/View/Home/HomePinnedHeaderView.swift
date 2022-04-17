//
//  HomePinnedHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct HomePinnedHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                buttonView(title: "", placeholder: "De unde", icon: "circle.circle") {
                    
                }
                
                Divider()
                
                buttonView(title: "", placeholder: "Direcție", icon: "circle.circle") {
                    
                }
                
                Divider()
                
                buttonView(title: "", placeholder: "Data", icon: "calendar") {
                    
                }
            }
            .padding(.top, 16)
            .padding(.horizontal)
            .background(.white)
            
            NavigationLink(destination: { RouteScheduleView() }) {
                Text("GĂSEȘTE RUTE")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, idealHeight: 48, alignment: .center)
            }
            .background(.blue)
        }
        .cornerRadius(14)
        .padding(.horizontal, 32)
    }
    
    @ViewBuilder
    private func buttonView(title: String, placeholder: String, icon: String, action: @escaping (() -> Void)) -> some View {
        let isEmptyTitle: Bool = title.isEmpty
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(!isEmptyTitle ? title : placeholder)
            }
            .frame(maxWidth: .infinity, idealHeight: 36, alignment: .leading)
        }
        .foregroundColor(!isEmptyTitle ? .black : .gray)
    }
}

struct HomePinnedHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
