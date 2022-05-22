//
//  HomeHeaderView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

struct HomeHeaderView: View {
//    init() { print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)") }
    
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
                        LinearGradient(colors: [
                            .clear,
                            Color.Theme.background
                        ], startPoint: .center, endPoint: .bottom)
                        
                        Text("Orarul rutelor din \nMoldova")
                            .foregroundColor(Color.hexFFFFFF)
                            .font(.title.bold())
                            .multilineTextAlignment(.center)
                            .frame(height: 200, alignment: .center)
                        // TODO: Add shadow
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: getRect().height * 0.4)
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
    }
}
