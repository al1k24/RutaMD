//
//  SelectIdentifiable.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 01.05.2022.
//

import SwiftUI

protocol SelectIdentifiable: Identifiable {
    var id: String { get }
    var name: String { get }
}
