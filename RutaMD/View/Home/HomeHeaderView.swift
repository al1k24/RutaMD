//
//  HomeHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct HomeHeaderView: View {
    private var headerImageHeight: CGFloat {
        return getRect().height * 0.4
    }
    
    var body: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            
            Image("home_header")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: height > 0 ? height : 0, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .top) {
                        
                        // Dimming Out the text Content
                        LinearGradient(colors: [
                            .clear,
                            .black.opacity(0.8)
                        ], startPoint: .bottom, endPoint: .top)
                        
                        Text("Orarul rutelor din \nMoldova")
                            .foregroundColor(.white)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                            .frame(height: 200, alignment: .center)
                    }
                })
                .cornerRadius(15)
                .offset(y: -minY)
        }
        .frame(height: headerImageHeight)
    }
    
    @ViewBuilder
    private func postHeader() -> some View {
        HStack(alignment: .top, spacing: 8) {
                Text("asdasdsa")
                    .foregroundColor(.red)
        }
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
