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
        DEBUG("* Success")
        
        self.startPoint = startPoint
        self.station = station
        self._dates = dates
        
        self.networkService = NetworkService()
    }
    
    deinit {
        DEBUG("* Success")
    }
    
    func load() {
        if !dates.isEmpty {
            state = .loaded(dates)
            return
        }
        
        guard let startPoint = startPoint else {
            state = .failed(.custom("please_select_a_location"))
            return
        }
        
        guard let station = station else {
            state = .failed(.custom("please_select_a_direction"))
            return
        }

        state = .loading
        
        let route = API.Station.getDates(startPoint: startPoint.id, station: station.id)
        networkService.request(route: route) { [weak self] (result: Result<JSONSerialisable, NetworkError>) in
            guard let self = self else {
                self?.state = .failed(.custom("no_data"))
                return
            }
            
            switch result {
            case .success(let response):
                let dates = response.content["date"].arrayValue
                    .compactMap({ $0.string?.toDate() })
                    .map({ DateModel(date: $0) })
                
                if self.dates.isEmpty && dates.isEmpty {
                    self.state = .failed(.custom("no_data"))
                    return
                }
                
                if !dates.isEmpty {
                    self.dates = dates
                }
                
                self.state = .loaded(self.dates)
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
