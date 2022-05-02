//
//  API.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation

enum API {}

extension API {
    static func getRequiredParams() -> [String: String] {
        return [
            "org": "all",
            "api_type": "avibus",
        ]
    }
}
