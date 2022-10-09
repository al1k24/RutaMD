//
//  HTMLContentService+ParseRouteDetailPlace.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 12.06.2022.
//

import Foundation
import SwiftHTMLParser

extension HTMLContentService {
    public func parseRouteDetailPlace(from element: Element) -> RouteDetailModel.Place? {
        guard let id = parseRouteDetailPlaceId(from: element) else {
            return nil
        }
        
        guard let isAvailable = parseRouteDetailPlaceAvailability(from: element) else {
            return nil
        }
        
        return .init(id: id, isAvailable: isAvailable)
    }
    
    private func parseRouteDetailPlaceId(from element: Element) -> Int? {
        return element.attributeValue(for: "data-place")?.toInt()
    }
    
    private func parseRouteDetailPlaceAvailability(from element: Element) -> Bool? {
        return element.attributeValue(for: "class")?.contains("blocked") == false
    }
}
