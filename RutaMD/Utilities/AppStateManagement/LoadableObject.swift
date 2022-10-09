//
//  LoadableObject.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import SwiftUI

protocol LoadableObject: ObservableObject {
    associatedtype Output
    
    var state: LoadingState<Output> { get }
    
    func load()
}
