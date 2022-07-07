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
        return UIApplication.shared.safeArea
    }
}
