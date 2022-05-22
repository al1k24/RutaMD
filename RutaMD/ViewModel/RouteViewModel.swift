//
//  RouteViewModel.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 19.04.2022.
//

import SwiftUI
import SwiftyJSON

final class RouteViewModel: ObservableObject {
    @Published var startPoint: StationModel? {
        didSet {
            station = nil
            stations.removeAll()
        }
    }
    
    @Published var station: StationModel? {
        didSet {
            date = nil
            dates.removeAll()
        }
    }
    
    @Published var date: DateModel?
    
    @Published var startPoints: [StationModel] = []
    @Published var stations: [StationModel] = []
    @Published var dates: [DateModel] = []
    
    init() {
        loadStartPoints()
    }
    
    private func loadStartPoints() {
        DispatchQueue.global(qos: .background).async {
            let file = "stations"
            guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
                print("* File \(file).json not found !")
                return
            }
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            
            guard let json = try? JSON(data: data) else {
                return
            }
            
            let serializedObject = ArraySerialisable<StationModel>(json: json)
            
            DispatchQueue.main.async {
                let stations = serializedObject.data
                
                self.startPoints = stations
                self.startPoint = stations.first
            }
        }
    }
}
