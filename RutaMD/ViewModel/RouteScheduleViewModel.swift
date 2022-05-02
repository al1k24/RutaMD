//
//  RouteScheduleViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

final class RouteScheduleViewModel: LoadableObject {
    typealias Output = [RouteModel]
    
    @Published private(set) var state = LoadingState<Output>.idle
    
    private let startPoint: StationModel?
    private let station: StationModel?
    private let date: DateModel?
    
    private let networkService: NetworkServiceProtocol
    private let htmlContentService: HTMLContentServiceProtocol
    
    init(startPoint: StationModel?, station: StationModel?, date: DateModel?) {
        self.startPoint = startPoint
        self.station = station
        self.date = date
        
        self.networkService = NetworkService()
        self.htmlContentService = HTMLContentService()
    }
    
    func load() {
        guard let startPoint = startPoint else {
            state = .failed(.custom("* Select startPoint"))
            return
        }
        
        guard let station = station else {
            state = .failed(.custom("* Select station"))
            return
        }
        
        guard let date = date else {
            state = .failed(.custom("* Select date"))
            return
        }
        
        state = .loading
        
        let route = API.Station.search(startPoint: startPoint.id, station: station.id, date: date.id).route
        networkService.request(route: route) { [weak self] (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                self?.htmlContentService.parse(from: data) { [weak self] (result: Result<[RouteModel], NetworkError>) in
                    switch result {
                    case .success(let routes):
                        self?.state = .loaded(routes)
                    case .failure(let error):
                        self?.state = .failed(error)
                    }
                }
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}
