//
//  Serialisable.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation
import SwiftyJSON

protocol Serialisable {
    init?(json: JSON)
}

protocol ErrorSerialisable {
    init(json: JSON)
    init(error: Error)
}

struct JSONSerialisable: Serialisable {
    let content: JSON
    let message: String?
    let type: APIResponseType?
    
    init(json: JSON) {
        content = json["content"]
        message = json["message"].string
        type = APIResponseType(rawValue: json["type"].stringValue)
    }
}

struct ArraySerialisable<T: Serialisable>: Serialisable {
    let data: [T]
    let message: String?
    let type: APIResponseType?
    
    init(json: JSON) {
        message = json["message"].string
        data = json["content"].arrayValue.compactMap({ T(json: $0) })
        
        type = APIResponseType(rawValue: json["type"].stringValue)
    }
}
