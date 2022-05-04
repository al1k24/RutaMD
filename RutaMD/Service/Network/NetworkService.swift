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

final class NetworkService: NetworkServiceProtocol {
    private var dataRequest: DataRequest?
    
    init() {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
    }
    
    deinit {
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        dataRequest?.cancel()
        dataRequest = nil
    }
    
    func request(route: Route, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        dataRequest?.cancel()
        
        guard let url = URL(string: BASE_URL)?.appendingPathComponent(route.path) else {
            self.dataRequest = nil
            completion(.failure(.url))
            return
        }
        
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        dataRequest = AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { [weak self] responseData in
                guard let data = responseData.data else {
                    self?.dataRequest = nil
                    completion(.failure(.custom("Invalid data")))
                    return
                }
                
                self?.dataRequest = nil
                completion(.success(data))
            }
    }
    
    func request<T: Serialisable>(route: Route, completion: @escaping (Result<T, NetworkError>) -> Void) {
        dataRequest?.cancel()
        
        guard let url = URL(string: BASE_URL)?.appendingPathComponent(route.path) else {
            self.dataRequest = nil
            completion(.failure(.url))
            return
        }
        
        print("[\(Date().formatted(date: .omitted, time: .standard))] \(Self.self): \(#function)")
        
        dataRequest = AF.request(url, method: route.method, parameters: route.params)
            .validate()
            .responseData { [weak self] responseData in
                guard let data = responseData.data else {
                    self?.dataRequest = nil
                    completion(.failure(.custom("Invalid data")))
                    return
                }
                
                do {
                    self?.dataRequest = nil
                    
                    let json = try JSON(data: data)
                    
                    if let serializedObject = T(json: json) {
                        completion(.success(serializedObject))
                    } else {
                        completion(.failure(.decoding))
                    }
                } catch {
                    self?.dataRequest = nil
                    
                    completion(.failure(.custom(error.localizedDescription)))
                }
            }
    }
}
