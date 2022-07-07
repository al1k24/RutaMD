//
//  HTMLContentService+ParseRouteDetailPlace.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 12.06.2022.
//

import Foundation

extension HTMLContentService {
    public func parseRouteDetailPlace(from element: Element) -> RouteDetailModel.Place? {
        guard let id = parseRouteDetailPlaceId(from: element) else {
            return nil
        }
        
        guard let isAvailable = parseRouteDetailPlaceAvailability(from: element) else {
            return nil
        }
        
        return .init(id: id,
                     isAvailable: isAvailable)
    }
    
    private func parseRouteDetailPlaceId(from element: Element) -> Int? {
        return element.openingTag.attributes["data-place"]?.value?.toInt()
    }
    
    private func parseRouteDetailPlaceAvailability(from element: Element) -> Bool? {
        return element.openingTag.attributes["class"]?.value?.contains("blocked") == false
    }
}
