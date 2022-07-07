//
//  StationModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import SwiftUI
import SwiftyJSON

struct StationModel: SelectIdentifiable, Serialisable {
    let id: String
    let name: String
    
    init?(json: JSON) {
        if json["COD"] == JSON.null || json["TITLE"] == JSON.null {
            return nil
        }
        
        guard let id = json["COD"].string, !id.isEmpty else {
            return nil
        }
        
        guard let name = json["TITLE"].string?.fixedName, !name.isEmpty else {
            return nil
        }
        
        self.id = id
        self.name = name
    }
}

extension StationModel: Hashable {}
