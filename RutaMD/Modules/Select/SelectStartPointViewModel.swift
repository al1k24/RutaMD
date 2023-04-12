//
//  SelectStartPointViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI
import SwiftUIKit

final class SelectStartPointViewModel: LoadableObject {
    typealias Output = [StationModel]
    
    @Published private(set) var state = LoadingState<Output>.idle
    
    private(set) var startPoints: Output = []
    
    init(startPoints: Output) {
        DEBUG("* Success")
        
        self.startPoints = startPoints
    }
    
    deinit {
        DEBUG("* Success")
    }
    
    func load() {
        if !startPoints.isEmpty {
            state = .loaded(startPoints)
            return
        }
        
        state = .failed(.custom("Don't have start points."))
        
        //TODO: Вынести загрузки json в отдельный класс, что ли ?!
    }
}
