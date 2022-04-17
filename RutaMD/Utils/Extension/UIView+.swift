//
//  UIView+.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 23.01.2022.
//

import SwiftUI

extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        if #available(iOS 15, *) {
            guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
                return .zero
            }
            
            return screen.windows.first?.safeAreaInsets ?? .zero
        } else {
            return UIApplication.shared.windows.first?.safeAreaInsets ?? .zero
        }
    }
}
