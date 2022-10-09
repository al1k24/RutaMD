//
//  Colors.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

extension Color {
    enum Theme {
        static let background = Color("background")
        
        enum Text {
            static let primary = Color("hex000000_FFFFFF")
            static let secondary = Color("hex777E90_A6A7BC")
        }
    }
    
    /// Blue
    static let hex3C71FF = Color("hex3C71FF")
    
    /// White
    static let hexFFFFFF = Color("hexFFFFFF")
    
    /// Green
    static let hex1BAA1A = Color("hex1BAA1A")
    
    /// Red
    static let hexFF364F = Color("hexFF364F")
    
    /// White - Black
    static let hexFFFFFF_000000 = Color("hexFFFFFF_000000")
    
    /// Black - White
    static let hex000000_FFFFFF = Color("hex000000_FFFFFF")
    
    /// Border
    static let hexF2F2F2_393F4D = Color("hexF2F2F2_393F4D")
    
    /// Tab view
    static let hexFFFFFF_393F4D = Color("hexFFFFFF_393F4D")
    
    static let hex777E90_A6A7BC = Color("hex777E90_A6A7BC")
    
    static let hexFFFFFF_232730 = Color("hexFFFFFF_232730")
}
