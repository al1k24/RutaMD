//
//  RouteScheduleViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI
import SwiftUIKit

// TODO: После деините убивать все активные запросы

final class RouteScheduleViewModel: LoadableObject {
    typealias Output = [RouteModel]
    
    @Published private(set) var state = LoadingState<Output>.idle
    
    private let startPoint: StationModel?
    private let station: StationModel?
    
    private(set) var date: DateModel? {
        didSet {
            updateCacheId()
        }
    }
    
    private var cacheId: RouteScheduleManager.CacheId?
    
    private var networkService: NetworkServiceProtocol
    private let htmlContentService: HTMLContentServiceProtocol
    
    public var scrollToDate: DateModel?
    
    init(startPoint: StationModel?, station: StationModel?, date: DateModel?) {
        DEBUG("* Success")
        
        self.startPoint = startPoint
        self.station = station
        self.date = date
        
        self.scrollToDate = date
        
        self.networkService = NetworkService()
        self.htmlContentService = HTMLContentService()
        
        updateCacheId()
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
        
        guard let date = date else {
            state = .failed(.custom("please_select_a_date"))
            return
        }
        
        let cachedRoutes = RouteScheduleManager.shared.getRoutes(cacheId)
        if !cachedRoutes.isEmpty {
            state = .loaded(cachedRoutes)
            return
        }
        
        state = .loading
        
        let route = API.Station.search(startPoint: startPoint.id, station: station.id, date: date.id)
        networkService.request(route: route, info: cacheId?.toInfo()) { [weak self] (result: Result<Data, NetworkError>, info: [String: Any]?) in
            let cacheId = RouteScheduleManager.shared.getCacheId(info)
            
            switch result {
            case .success(let data):
                self?.htmlContentService.parse(from: data) { [weak self] (result: Result<[RouteModel], NetworkError>) in
                    guard let self = self else {
                        if self?.cacheId == cacheId {
                            self?.state = .failed(.custom("no_data"))
                        }
                        return
                    }
                    
                    switch result {
                    case .success(let routes):
                        RouteScheduleManager.shared.save(routes: routes, cacheId: cacheId)
                        
                        if self.cacheId == cacheId {
                            self.state = routes.isEmpty
                                ? .failed(.custom("no_data"))
                                : .loaded(routes)
                        }
                    case .failure(let error):
                        if self.cacheId == cacheId {
                            self.state = .failed(error)
                        }
                    }
                }
            case .failure(let error):
                if self?.cacheId == cacheId {
                    self?.state = .failed(error)
                }
            }
        }
    }
    
    func select(_ model: DateModel) {
        if self.date?.id == model.id {
            return
        }
        
        self.date = model
        load()
    }
    
    func toDisplay() -> String {
        return (date?.date ?? Date()).toDisplay()
    }
    
    func isToday(_ model: DateModel) -> Bool {
        guard let currentDate = date?.date else {
            return false
        }
        
        return Calendar.current.isDate(currentDate, inSameDayAs: model.date)
    }
    
    private func updateCacheId() {
        guard let startPoint = startPoint, let station = station, let date = date else {
            cacheId = nil
            return
        }
        
        cacheId = .init(startPointId: startPoint.id, stationId: station.id, dateId: date.id)
    }
}
