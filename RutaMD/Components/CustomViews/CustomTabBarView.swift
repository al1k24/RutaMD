//
//  CustomTabBarView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var currentTab: TabType
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabType.allCases, id: \.rawValue) { tab in
                Button(action: { currentTab = tab }) {
                    Image(systemName: tab.getIcon(isFilled: currentTab == tab))
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(currentTab == tab ? Color.hex3C71FF : Color.hex777E90_A6A7BC)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 30)
        .padding(.bottom, 10)
        .padding([.horizontal, .top])
    }
}
