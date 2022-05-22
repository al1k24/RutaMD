//
//  String+.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import Foundation

extension String {
    var addBaseURL: String {
        return BASE_URL + self
    }
    
    func clearHTLMTags() -> String {
        return self
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
    }
}
