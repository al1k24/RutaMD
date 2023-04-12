//
//  UIApplication+.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 12.06.2022.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        getKeyWindow()?.endEditing(force)
    }
}
