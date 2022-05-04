//
//  SelectDateViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

final class SelectDateViewModel: LoadableObject {
    typealias Output = [DateModel]
    
    @Published private(set) var state = LoadingState<Output>.idle
    
    @Binding private(set) var dates: Output
    
    private let station: StationModel?
    private let startPoint: StationModel?
    
    private var networkService: NetworkServiceProtocol
    
    init(startPoint: StationModel?, station: StationModel?, dates: Binding<Output>) {
        self.startPoint = startPoint
        self.station = station
        self._dates = dates
        
        self.networkService = NetworkService()
    }
    
    func load() {
        if !dates.isEmpty {
            state = .loaded(dates)
            return
        }
        
        guard let startPoint = startPoint else {
            state = .failed(.custom("Invalid start point"))
            return
        }
        
        guard let station = station else {
            state = .failed(.custom("Invalid station"))
            return
        }

        state = .loading
        
        let route = API.Station.getDates(startPoint: startPoint.id, station: station.id).route
        networkService.request(route: route) { [weak self] (result: Result<JSONSerialisable, NetworkError>) in
            switch result {
            case .success(let response):
                let dates = response.content["date"].arrayValue
                    .compactMap({ $0.string?.toDate() })
                    .map({ DateModel(date: $0) })
                
                if !dates.isEmpty {
                    self?.dates = dates
                }
                self?.state = .loaded(dates)
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}
