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
    func request(route: Route, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func request<T: Serialisable>(route: Route, completion: @escaping (Result<T, NetworkError>) -> Void)
}

struct NetworkService: NetworkServiceProtocol {
    func request(route: Route, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: BASE_URL)?.appendingPathComponent(route.path) else {
            return
        }
        
        AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { responseData in
                guard let data = responseData.data else {
                    return
                }
                
                completion(.success(data))
            }
    }
    
    func request<T: Serialisable>(route: Route, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: BASE_URL)?.appendingPathComponent(route.path) else {
            return
        }
        
        AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { responseData in
//                switch response {
//                case .success(let data):
                guard let data = responseData.data else {
                    
                    return
                }
                    do {
                        let json = try JSON(data: data)
                        
                        if let serializedObject = T(json: json) {
//                            DispatchQueue.main.async {
                                completion(.success(serializedObject))
//                            }
                        } else {
//                            DispatchQueue.main.async {
//                                let error = EBSError.objectSerializationIssue(className: "\(T.self)", json)
//                                completion(.failure(E(error: error)))
                                completion(.failure(.decoding))
//                            }
                        }
                    } catch {
//                        DispatchQueue.main.async {
//                            let error = EBSError.jsonSerializationFailed(error)
//                            completionHandler(.failure(E(error: error)))
//                        }
                    }
            }
    }
}
