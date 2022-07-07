//
//  UIApplication+.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 12.06.2022.
//

import SwiftUI

extension UIApplication {
    var scene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first as? UIWindowScene
    }
    
    var safeArea: UIEdgeInsets {
        return scene?.windows.first?.safeAreaInsets ?? .zero
    }
    
    func endEditing(_ force: Bool) {
        scene?.windows.first?.endEditing(force)
    }
}
