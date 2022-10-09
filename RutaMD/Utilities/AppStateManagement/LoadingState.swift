//
//  LoadingState.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading
    case failed(NetworkError)
    case loaded(Value)
}
