//
//  DateModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI
import SwiftyJSON

struct DateModel: SelectIdentifiable {
    let id: String
    let name: String
    
    let date: Date
    
    init(date: Date) {
        self.date = date
        self.id = date.toAPI()
        self.name = date.toDisplay()
    }
}

extension DateModel: Hashable {}
