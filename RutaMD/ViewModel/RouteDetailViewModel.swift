//
//  RouteDetailViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import SwiftUI

final class RouteDetailViewModel: LoadableObject {
    typealias Output = RouteDetailModel
    
    @Published private(set) var state = LoadingState<Output>.idle
    
    private let route: RouteModel
    private var routeDetail: RouteDetailModel
    
    private var networkService: NetworkServiceProtocol
    private let htmlContentService: HTMLContentServiceProtocol
    
    init(route: RouteModel) {
        self.route = route
        self.routeDetail = .init(id: route.id, name: route.name, stations: [])
        
        self.networkService = NetworkService()
        self.htmlContentService = HTMLContentService()
    }
    
    func load() {
        state = .loading
        
        let route = API.Station.getRouteDetail(route: route.components.route,
                                               date: route.components.date.toAPI(),
                                               routeCode: route.components.routeCode)
        networkService.request(route: route) { [weak self] (result: Result<Data, NetworkError>) in
            switch result {
            case .success(let data):
                self?.htmlContentService.parse(from: data) { [weak self] (result: Result<[RouteDetailModel.Station], NetworkError>) in
                    guard let self = self else {
                        self?.state = .failed(.custom("* Weak self"))
                        return
                    }
                    
                    switch result {
                    case .success(let stations):
                        self.routeDetail = .init(id: self.route.id, name: self.route.name, stations: stations)
                        self.state = .loaded(self.routeDetail)
                    case .failure(let error):
                        self.state = .failed(error)
                    }
                }
            case .failure(let error):
                self?.state = .failed(error)
            }
        }
    }
    
    func getTitle() -> String {
        return "Ruta #\(route.id)"
    }
    
    func getBuyURL() -> URL? {
        return route.buyComponents.url
    }
}
