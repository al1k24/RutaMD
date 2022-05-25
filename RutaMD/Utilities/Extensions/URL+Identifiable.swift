//
//  URL+Identifiable.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 25.05.2022.
//

import UIKit

extension URL: Identifiable {
    public var id: Int {
        return hashValue
    }
}
