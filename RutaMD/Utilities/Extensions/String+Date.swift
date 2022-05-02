//
//  String+Date.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import Foundation

private var apiDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()

private var displayDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMM yyyy"
    return dateFormatter
}()

extension String {
    func toDate() -> Date? {
        return apiDateFormatter.date(from: self)
    }
}

extension Date {
    func toAPI() -> String {
        return apiDateFormatter.string(from: self)
    }
    
    func toDisplay() -> String {
        return displayDateFormatter.string(from: self)
    }
}
