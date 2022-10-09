//
//  Label+String.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.06.2022.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(_ title: String?, placeholder: String, systemImage name: String) {
        if let title = title {
            self.init(title, systemImage: name)
        } else {
            self.init(LocalizedStringKey(placeholder), systemImage: name)
        }
    }
}
