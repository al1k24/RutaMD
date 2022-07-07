//
//  API+Station.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation

extension String {
    var widgetPath: String {
        return "widget_avibus/include/" + self
    }
}

extension API {
    enum Station: APIRoute {
        case getStations(startPoint: String)
        case getDates(startPoint: String, station: String)
        case getRouteDetail(route: String, date: String, routeCode: String)
        case search(startPoint: String, station: String, date: String)
        case getRoutePlaces(route: String, startPoint: String, destination: String, routeCode: String, date: String, time: String)
        
        var route: Route {
            var params: [String: String] = getDefaultParams()
//            params["ru"] = ""
            
            switch self {
            case .getStations(let startPoint):
                params["startPoint"] = startPoint
                
                return Route(.get, path: "getStations.php".widgetPath, params: params)
                
            case .getDates(let startPoint, let station):
                params["startPoint"] = startPoint
                params["station"] = station
                
                return Route(.get, path: "getDates.php".widgetPath, params: params)
                
            case .getRouteDetail(let route, let date, let routeCode):
                params["route"] = route
                params["data"] = date
                params["RouteCode"] = routeCode
                
                return Route(.get, path: "routeDetail.php".widgetPath, params: params)
                
            case .search(let startPoint, let station, let date):
                params["startPoint"] = startPoint
                params["station"] = station
                params["data"] = date
                
                return Route(.get, path: "do_search.php".widgetPath, params: params)
                
            case .getRoutePlaces(let route, let startPoint, let destination, let routeCode, let date, let time):
                params["event"] = route
                params["startPoint"] = startPoint
                params["destination"] = destination
                params["RouteCode"] = routeCode
                params["date"] = date
                params["time"] = time
                
                return Route(.get, path: "schema.php", params: params)
            }
        }
    }
}

extension API.Station {
    func getDefaultParams() -> [String: String] {
        switch self {
        case .getStations, .getDates:
            return [
                "org": "all",
                "api_type": "avibus"
            ]
        case .getRouteDetail:
            return [
                "connect_type": "web",
                "api_type": "avibus"
            ]
        case .search:
            return [
                "org": "all",
                "api_type": "avibus",
                "connect_type": "web"
            ]
        case .getRoutePlaces:
            return [
                "org": "autogara",
                "casir_email": "0",
                "sector": ""
            ]
        }
    }
}
