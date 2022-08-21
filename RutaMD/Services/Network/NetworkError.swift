//
//  NetworkError.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation

enum NetworkError: Error {
    case url
    case network
    case decoding
    case custom(String)
}

// TODO: Add localisations 
extension NetworkError {
    var localizedKey: String {
        switch self {
        case .url:
            return "An error occurred while checking URL "
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        case .custom(let key):
            return key
        }
    }
}
