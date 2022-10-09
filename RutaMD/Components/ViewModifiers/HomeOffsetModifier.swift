//
//  HomeOffsetModifier.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 17.04.2022.
//

import SwiftUI

struct HomeOffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    // Optional to return value from 0
    var returnFromStart: Bool = true
    
    @State private var startValue: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: HomeOffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(HomeOffsetKey.self) { value in
                            if startValue == 0 {
                                startValue = value
                            }
                            
                            offset = (value - (returnFromStart ? startValue : 0))
                        }
                }
            }
    }
}

// MARK: Preference Key
struct HomeOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
