//
//  Text+String.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.06.2022.
//

import SwiftUI

extension Text {
    init(_ text: String?, placeholder: String) {
        if let text = text {
            self.init(text)
        } else {
            self.init(LocalizedStringKey(placeholder))
        }
    }
}
