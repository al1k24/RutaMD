//
//  String+URL.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 26.05.2022.
//

import UIKit

extension String {
    func toValidURL() -> URL? {
        guard let url = URL(string: self), UIApplication.shared.canOpenURL(url) else {
            return nil
        }
        
        return url
    }
}
