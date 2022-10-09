//
//  Array+.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < self.count else {
            return nil
        }
        
        return self[index]
    }
}
