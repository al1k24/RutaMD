//
//  CorneredRectangle.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 28.05.2022.
//

import SwiftUI

struct CorneredRectangle: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CorneredRectangle(radius: radius, corners: corners))
    }
}
