//
//  HTMLContentService+ParseRoute.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.05.2022.
//

import Foundation
import SwiftHTMLParser

extension HTMLContentService {
    public func parseRoute(from element: Element) -> RouteModel? {
        guard let id = parseRouteId(from: element) else {
            return nil
        }
        
        guard let name = parseRouteName(from: element) else {
            return nil
        }
        
        guard let info = parseRouteInfo(from: name) else {
            return nil
        }
        
        guard let date = parseRouteDate(from: element) else {
            return nil
        }
        
        guard let time = parseRouteTime(from: element) else {
            return nil
        }
        
        guard let distance = parseRouteDistance(from: element) else {
            return nil
        }
        
        guard let price = parseRoutePrice(from: element) else {
            return nil
        }
        
        guard let components = parseRouteComponents(from: element) else {
            return nil
        }
        
        guard let buyComponents = parseRouteBuyComponents(from: element) else {
            return nil
        }
        
        return .init(id: id,
                     name: name,
                     info: .init(startPoint: info.startPoint,
                                 destination: info.destination),
                     date: date,
                     time: time,
                     distance: distance,
                     price: price,
                     components: .init(route: components.route,
                                       routeCode: components.routeCode,
                                       date: components.date,
                                       time: time),
                     buyComponents: .init(name: buyComponents.name,
                                          url: buyComponents.url))
    }
    
    private func parseRouteId(from element: Element) -> String? {
        return element.childElements[safe: 4]?.textNodes.first?.text
    }
    
    private func parseRouteName(from element: Element) -> String? {
        return element.childElements[safe: 1]?.childElements[safe: 0]?.textNodes.first?.text
            .fixedName
    }
    
    private func parseRouteInfo(from name: String) -> (startPoint: String, destination: String)? {
        let infoComponents: [String] = name.components(separatedBy: "->")
        
        guard infoComponents.count > 1 else {
            return nil
        }
        
        guard let startPoint = infoComponents[safe: 0], !startPoint.isEmpty else {
            return nil
        }
        
        guard let destination = infoComponents[safe: 1], !destination.isEmpty else {
            return nil
        }
        
        return (startPoint: startPoint, destination: destination)
    }
    
    private func parseRouteDate(from element: Element) -> Date? {
        return element.childElements[safe: 2]?.textNodes.first?.text.toDate()
    }
    
    private func parseRouteTime(from element: Element) -> String? {
        return element.childElements[safe: 3]?.textNodes.first?.text
            .replacingOccurrences(of: ".", with: ":")
    }
    
    private func parseRouteDistance(from element: Element) -> String? {
        return element.childElements[safe: 5]?.textNodes.first?.text
    }
    
    private func parseRoutePrice(from element: Element) -> String? {
        return element.childElements[safe: 6]?.textNodes.first?.text
    }
    
    private func parseRouteBuyComponents(from element: Element) -> (name: String, url: URL?)? {
        guard let childElement = element.childElements[safe: 7]?.childElements.first else {
            return nil
        }
        
        let url = childElement.tagName == "a"
            ? childElement.attributeValue(for: "href")?.addBaseURL.toValidURL()
            : nil
        
        let name: String = url == nil
            ? "canceled"
            : "buy"
        
        return (name: name, url: url)
    }
    
    private func parseRouteComponents(from element: Element) -> (route: String, routeCode: String, date: Date)? {
        guard let childElement = element.childElements[safe: 0]?.childElements[safe: 0] else {
            return nil
        }
        
        guard let route = childElement.attributeValue(for: "route") else {
            return nil
        }
        
        guard let routeCode = childElement.attributeValue(for: "RouteCode") else {
            return nil
        }
        
        guard let date = childElement.attributeValue(for: "data")?.toDate() else {
            return nil
        }
        
        return (route: route, routeCode: routeCode, date: date)
    }
}
