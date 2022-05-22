//
//  HTMLContentService+ParseRouteDetail.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.05.2022.
//

import Foundation

extension HTMLContentService {
    public func parseRouteDetailStation(id: Int, from element: Element) -> RouteDetailModel.Station? {
        guard let name = parseRouteDetailName(from: element) else {
            return nil
        }
        
        guard let date = parseRouteDetailDate(from: element) else {
            return nil
        }
        
        let time = parseRouteDetailTime(from: element)
        
        guard let distance = parseRouteDetailDistance(from: element) else {
            return nil
        }
        
        guard let price = parseRouteDetailPrice(from: element) else {
            return nil
        }
        
        return .init(id: id,
                     name: name,
                     date: date,
                     time: time,
                     distance: distance,
                     price: price)
    }
    
    private func parseRouteDetailName(from element: Element) -> String? {
        return element.childElements[safe: 1]?.textNodes.first?.text
    }
    
    private func parseRouteDetailDate(from element: Element) -> Date? {
        return element.childElements[safe: 2]?.textNodes.first?.text.toDate()
    }
    
    private func parseRouteDetailTime(from element: Element) -> String? {
        return element.childElements[safe: 3]?.textNodes.first?.text
            .replacingOccurrences(of: ".", with: ":")
    }
    
    private func parseRouteDetailDistance(from element: Element) -> String? {
        return element.childElements[safe: 5]?.textNodes.first?.text
    }
    
    private func parseRouteDetailPrice(from element: Element) -> String? {
        return element.childElements[safe: 6]?.textNodes.first?.text
    }
}
