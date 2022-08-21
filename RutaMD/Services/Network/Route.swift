//
//  Route.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation
import Alamofire

struct Route {
    private(set) var method: HTTPMethod
    private(set) var path: String
    private(set) var params: Parameters?
    
    init(_ method: HTTPMethod = .get, path: String, params: Parameters? = nil) {
        self.method = method
        self.path = path
        self.params = params
    }
}
