//
//  HTMLContentService.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import Foundation
import SwiftSoup

// Source: https://github.com/rnantes/swift-html-parser

protocol HTMLContentServiceProtocol {
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteModel], NetworkError>) -> Void))
}

struct HTMLContentService: HTMLContentServiceProtocol {
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteModel], NetworkError>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            guard let html = String(data: data, encoding: .utf8)?.clearHTLMTags() else {
                completion(.failure(.decoding))
                return
            }
            
            do {
                let nodeTree = try HTMLParser.parse(html)
                
                // create a node selector path to describe what nodes to match in the nodeTree
                let nodeSelectorPath: [NodeSelector] = [
                    ElementSelector().withTagName("tr")
                ]

                // find the nodes that match the nodeSelectorPath
                let matchingNodes = HTMLTraverser.findElements(in: nodeTree, matching: nodeSelectorPath)
                
                // parse all content
                let routes = matchingNodes.compactMap({ parseRouteModel(from: $0) })
                
                DispatchQueue.main.async {
                    completion(.success(routes))
                }
            } catch {
                completion(.failure(.custom(error.localizedDescription)))
                print("* HTML Parser -> Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func parseRouteModel(from element: Element) -> RouteModel? {
        guard let id = parseRouteId(from: element) else {
            return nil
        }
        
        guard let name = parseRouteName(from: element) else {
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
                     date: date,
                     time: time,
                     distance: distance,
                     price: price,
                     components: .init(route: components.route,
                                       routeCode: components.routeCode,
                                       date: components.date),
                     buyComponents: .init(name: buyComponents.name,
                                          url: buyComponents.url))
    }
    
    private func parseRouteId(from element: Element) -> String? {
        return element.childElements[safe: 4]?.textNodes.first?.text
    }
    
    private func parseRouteName(from element: Element) -> String? {
        return element.childElements[safe: 1]?.childElements[safe: 0]?.textNodes.first?.text
    }
    
    private func parseRouteDate(from element: Element) -> Date? {
        return element.childElements[safe: 2]?.textNodes.first?.text.toDate()
    }
    
    private func parseRouteTime(from element: Element) -> String? {
        return element.childElements[safe: 3]?.textNodes.first?.text
    }
    
    private func parseRouteDistance(from element: Element) -> String? {
        return element.childElements[safe: 5]?.textNodes.first?.text
    }
    
    private func parseRoutePrice(from element: Element) -> String? {
        return element.childElements[safe: 6]?.textNodes.first?.text
    }
    
    private func parseRouteBuyComponents(from element: Element) -> (name: String, url: String?)? {
        guard let childElement = element.childElements[safe: 7]?.childElements.first else {
            return nil
        }
        
        guard let name = childElement.textNodes.first?.text else {
            return nil
        }
        
        if childElement.openingTag.tagName == "a" {
            let url = childElement.openingTag.attributes["href"]?.value
            return (name: name, url: url)
        } else if childElement.openingTag.tagName == "span" {
            return (name: name, url: nil)
        }
        
        return nil
    }
    
    private func parseRouteComponents(from element: Element) -> (route: String, routeCode: String, date: Date)? {
        guard let childElement = element.childElements[safe: 0]?.childElements[safe: 0]?.openingTag else {
            return nil
        }
        
        guard let route = childElement.attributes["route"]?.value else {
            return nil
        }
        
        guard let routeCode = childElement.attributes["RouteCode"]?.value else {
            return nil
        }
        
        guard let date = childElement.attributes["data"]?.value?.toDate() else {
            return nil
        }
        
        return (route: route, routeCode: routeCode, date: date)
    }
}
