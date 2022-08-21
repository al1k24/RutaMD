//
//  NetworkService.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

// TODO: Need refactoring

protocol NetworkServiceProtocol {
    func request(route apiRoute: APIRoute, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request(route apiRoute: APIRoute, info: [String: Any]?, completion: @escaping (_ result: Result<Data, NetworkError>, _ info: [String: Any]?) -> Void)
    func request<T: Serialisable>(route apiRoute: APIRoute, completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    init() {
        DEBUG("* Success")
    }
    
    deinit {
        DEBUG("* Success")
    }
    
    func request(route apiRoute: APIRoute, info: [String: Any]?, completion: @escaping (_ result: Result<Data, NetworkError>, _ info: [String: Any]?) -> Void) {
        let route = apiRoute.route
        
        guard let url = URL(string: BASE_API_URL)?.appendingPathComponent(route.path) else {
            completion(.failure(.url), info)
            return
        }
        
        AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { responseData in
                guard let data = responseData.data else {
                    completion(.failure(.custom("Invalid data")), info)
                    return
                }
                
                completion(.success(data), info)
            }
    }

    func request(route apiRoute: APIRoute, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let route = apiRoute.route
        
        guard let url = URL(string: BASE_API_URL)?.appendingPathComponent(route.path) else {
            completion(.failure(.url))
            return
        }
        
        AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { responseData in
                guard let data = responseData.data else {
                    completion(.failure(.custom("Invalid data")))
                    return
                }
                
                completion(.success(data))
            }
    }
    
    func request<T: Serialisable>(route apiRoute: APIRoute, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let route = apiRoute.route
        
        guard let url = URL(string: BASE_API_URL)?.appendingPathComponent(route.path) else {
            completion(.failure(.url))
            return
        }
        
        AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { responseData in
                guard let data = responseData.data else {
                    completion(.failure(.custom("Invalid data")))
                    return
                }
                
                do {
                    let json = try JSON(data: data)
                    
                    if let serializedObject = T(json: json) {
                        completion(.success(serializedObject))
                    } else {
                        completion(.failure(.decoding))
                    }
                } catch {
                    completion(.failure(.custom(error.localizedDescription)))
                }
            }
    }
}
