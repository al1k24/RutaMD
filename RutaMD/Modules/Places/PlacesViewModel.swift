//
//  PlacesViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 12.06.2022.
//

import SwiftUI
import SwiftUIKit

final class PlacesViewModel: LoadableObject {
    typealias Output = [RouteDetailModel.Place]
    
    @Published private(set) var state = LoadingState<Output>.idle
    
    private let route: RouteModel
    private let station: StationModel?
    private let startPoint: StationModel?
    
    private var networkService: NetworkServiceProtocol
    private let htmlContentService: HTMLContentServiceProtocol
    
    init(startPoint: StationModel?, station: StationModel?, route: RouteModel) {
        DEBUG("* Success")
        
        self.startPoint = startPoint
        self.station = station
        self.route = route
        
        self.networkService = NetworkService()
        self.htmlContentService = HTMLContentService()
    }
    
    deinit {
        DEBUG("* Success")
    }
    
    func load() {
        guard let startPoint = startPoint else {
            state = .failed(.custom("please_select_a_location"))
            return
        }
        
        guard let station = station else {
            state = .failed(.custom("please_select_a_direction"))
            return
        }
        
        state = .loading
        
        let route = API.Station.getRoutePlaces(route: route.components.route,
                                               startPoint: startPoint.id,
                                               destination: station.id,
                                               routeCode: route.components.routeCode,
                                               date: route.components.date.toDisplay(format: "dd.MM.yyyy"),
                                               time: route.components.time)
        networkService.request(route: route) { [weak self] (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                self?.htmlContentService.parse(from: data) { [weak self] (result: Result<[RouteDetailModel.Place], NetworkError>) in
                    guard let self = self else {
                        self?.state = .failed(.custom("no_data"))
                        return
                    }
                    
                    switch result {
                    case .success(let places):
                        self.state = .loaded(places)
                    case .failure(let error):
                        self.state = .failed(error)
                    }
                }
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
}
