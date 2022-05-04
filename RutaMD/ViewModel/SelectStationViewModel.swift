//
//  SelectStationViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 20.04.2022.
//

import SwiftUI

final class SelectStationViewModel: LoadableObject {
    typealias Output = [StationModel]
    
    @Binding private(set) var stations: Output
    @Published private(set) var state = LoadingState<Output>.idle
    
    private let startPoint: StationModel?
    private var networkService: NetworkServiceProtocol
    
    init(startPoint: StationModel?, stations: Binding<Output>) {
        self.startPoint = startPoint
        self._stations = stations
        
        self.networkService = NetworkService()
    }
    
    func load() {
        if !stations.isEmpty {
            state = .loaded(stations)
            return
        }
        
        guard let startPoint = startPoint else {
            state = .failed(.custom("Invalid start point"))
            return
        }

        state = .loading
        
        let route = API.Station.getStations(startPoint: startPoint.id).route
        networkService.request(route: route) { [weak self] (result: Result<ArraySerialisable<StationModel>, NetworkError>) in
            switch result {
            case .success(let response):
                let stations = response.data
                
                if !stations.isEmpty {
                    self?.stations = stations
                }
                self?.state = .loaded(stations)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}
