//
//  String+.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 02.05.2022.
//

import UIKit

extension String {
    var addBaseURL: String {
        return BASE_URL + self
    }
    
    var fixedName: String? {
        let components = self.components(separatedBy: " ")
        guard components.count > 1, let prefix = components.first else {
            return self
        }
        
        return self
            .components(separatedBy: "(\(prefix)").first?
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func clearHTLMTags() -> String {
        return self
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "\r", with: "")
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
}
