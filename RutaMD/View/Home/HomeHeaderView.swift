//
//  HomeHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct HomeHeaderView: View {
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
                    ZStack(alignment: .center) {
                        LinearGradient(colors: [
                            .clear,
                            Color.Theme.background
                        ], startPoint: .center, endPoint: .bottom)
                        
                        Text("moldova_route_schedule")
                            .foregroundColor(Color.hexFFFFFF)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                            .shadow(radius: 10)
                            .offset(y: -45)
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: getRect().height * 0.45)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
