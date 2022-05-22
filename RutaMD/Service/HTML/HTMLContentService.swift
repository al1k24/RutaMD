//
//  HTMLContentService.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import Foundation

// Source: https://github.com/rnantes/swift-html-parser

protocol HTMLContentServiceProtocol {
    /// Parse route models
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteModel], NetworkError>) -> Void))
    
    /// Parse Route detail station models
    func parse(from data: Data, completion: @escaping ((_ result: Result<[RouteDetailModel.Station], NetworkError>) -> Void))
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
                completion(.failure(.custom(error.localizedDescription)))
                print("* HTML Parser -> Error: \(error.localizedDescription)")
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
                completion(.failure(.custom(error.localizedDescription)))
                print("* HTML Parser -> Error: \(error.localizedDescription)")
            }
        }
    }
}
