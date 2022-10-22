//
//  SelectStartPointViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

final class SelectStartPointViewModel: LoadableObject {
    @Published private(set) var state = LoadingState<[StationModel]>.idle
    
    private(set) var startPoints: [StationModel] = []
    
    init(startPoints: [StationModel]) {
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
