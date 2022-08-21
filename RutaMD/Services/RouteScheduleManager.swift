//
//  RouteScheduleManager.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 14.08.2022.
//

import Foundation

final class RouteScheduleManager {
    private init() {}
    
    static let shared = RouteScheduleManager()
    
    private(set) var cache: Set<Cache> = []
    
    func isLoading(_ cacheId: CacheId?) -> Bool {
        return self.cache.first(where: { $0.id == cacheId })?.routes.isEmpty == true
    }
    
    func getRoutes(_ cacheId: CacheId?) -> [RouteModel] {
        return self.cache.first(where: { $0.id == cacheId })?.routes ?? []
    }
    
    func getCacheId(_ info: [String: Any]?) -> CacheId? {
        guard let startPointId = info?["startPointId"] as? String,
              let stationId = info?["stationId"] as? String,
              let dateId = info?["dateId"] as? String else {
            return nil
        }
        
        return .init(startPointId: startPointId, stationId: stationId, dateId: dateId)
    }
    
    func save(routes: [RouteModel], cacheId: CacheId?) {
        guard let cacheId = cacheId else {
            return
        }
        
        if cache.contains(where: { $0.id == cacheId }) {
            cache.first(where: { $0.id == cacheId })?.set(routes)
        } else {
            cache.insert(.init(cacheId, routes: routes))
        }
    }
}

extension RouteScheduleManager {
    enum CacheState {
        case loading
        case loaded([RouteModel])
    }
    
    struct CacheId {
        var startPointId: String
        var stationId: String
        var dateId: String
        
        func toInfo() -> [String: Any] {
            return [
                "startPointId": startPointId,
                "stationId": stationId,
                "dateId": dateId
            ]
        }
    }
    
    final class Cache {
        private(set) var id: CacheId
        private(set) var routes: [RouteModel] = []
        
        init(_ id: CacheId, routes: [RouteModel] = []) {
            self.id = id
            self.routes = routes
        }
        
        func set(_ routes: [RouteModel]) {
            self.routes = routes
        }
    }
}

extension RouteScheduleManager.CacheId: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(startPointId)
        hasher.combine(stationId)
        hasher.combine(dateId)
    }
}

extension RouteScheduleManager.Cache: Hashable {
    static func == (lhs: RouteScheduleManager.Cache, rhs: RouteScheduleManager.Cache) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
