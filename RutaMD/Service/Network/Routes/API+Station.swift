//
//  API+Station.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation

extension API {
    enum Station: APIRoute {
        case getStations(startPoint: String)
        case getDates(startPoint: String, station: String)
        case search(startPoint: String, station: String, date: String)
        
        var route: Route {
            switch self {
            case .getStations(let startPoint):
                var params: [String: String] = API.getRequiredParams()
                params["startPoint"] = startPoint
                
                return Route(.get, path: "getStations.php", params: params)
                
            case .getDates(let startPoint, let station):
                var params: [String: String] = API.getRequiredParams()
                params["startPoint"] = startPoint
                params["station"] = station
                
                return Route(.get, path: "getDates.php", params: params)
                
            case .search(let startPoint, let station, let date):
                var params: [String: String] = API.getRequiredParams()
                params["startPoint"] = startPoint
                params["station"] = station
                params["data"] = date
                
                return Route(.get, path: "do_search.php", params: params)
            }
        }
    }
}
