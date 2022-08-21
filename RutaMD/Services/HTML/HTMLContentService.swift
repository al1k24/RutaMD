//
//  HTMLContentService.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import Foundation
import SwiftHTMLParser

protocol HTMLContentServiceProtocol {
    /// Parse route models
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteModel], NetworkError>) -> Void))
    
    /// Parse Route detail station models
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteDetailModel.Station], NetworkError>) -> Void))
    
    /// Parse Route detail place models
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteDetailModel.Place], NetworkError>) -> Void))
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
                let matchingNodes = HTMLTraverser.findElements(in: nodeTree, matching: [])
                
                // parse all content
                let routes = matchingNodes.compactMap({ parseRoute(from: $0) })
                
                DispatchQueue.main.async {
                    completion(.success(routes))
                }
            } catch {
                print("* HTML Parser -> Error: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completion(.failure(.custom(error.localizedDescription)))
                }
            }
        }
    }
    
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteDetailModel.Station], NetworkError>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            guard let html = String(data: data, encoding: .utf8)?.clearHTLMTags() else {
                completion(.failure(.decoding))
                return
            }
            
            do {
                let nodeTree = try HTMLParser.parse(html)
                let matchingNodes = HTMLTraverser.findElements(in: nodeTree, matching: [])
                
                let stationElements = matchingNodes.first? //<td>
                    .childElements.first? // <table>
                    .childElements.first? // <tbody>
                    .childElements // [<tr>]
                
                // parse all content
                let stations = stationElements?
                    .enumerated()
                    .compactMap({ parseRouteDetailStation(id: $0.offset, from: $0.element) }) ?? []
                
                DispatchQueue.main.async {
                    completion(.success(stations))
                }
            } catch {
                print("* HTML Parser -> Error: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completion(.failure(.custom(error.localizedDescription)))
                }
            }
        }
    }
    
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteDetailModel.Place], NetworkError>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            guard let html = String(data: data, encoding: .utf8)?.clearHTLMTags() else {
                completion(.failure(.decoding))
                return
            }
            
            do {
                let nodeTree = try HTMLParser.parse(html)
                let matchingNodes = HTMLTraverser.findElements(in: nodeTree, matching: [])
                
                let placeElements = matchingNodes.first? //<div class=\'schema\' ...>
                    .childElements.first? // <div class=\'places\' ...>
                    .childElements // [<button>]

                // parse all content
                let places = placeElements?
                    .compactMap({ parseRouteDetailPlace(from: $0) }) ?? []
                
                DispatchQueue.main.async {
                    completion(.success(places))
                }
            } catch {
                print("* HTML Parser -> Error: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    completion(.failure(.custom(error.localizedDescription)))
                }
            }
        }
    }
}
