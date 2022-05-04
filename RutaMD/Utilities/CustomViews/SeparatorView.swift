//
//  SeparatorView.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 04.05.2022.
//

import SwiftUI

struct SeparatorView: View {
    private let height: CGFloat
    
    init(height: CGFloat = 1) {
        self.height = height
    }
    
    var body: some View {
        Color.hexF2F2F2_393F4D
            .frame(height: height)
    }
}

struct SeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        SeparatorView()
    }
}
