//
//  UIDevice+Vibration.swift
//  RutaMD
//
//  Created by Alik Moldovanu on 13.08.2022.
//

import UIKit
import AVFoundation

public extension UIDevice {
    enum Vibration {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        case soft
        case rigid
        case selection
        case oldSchool
    }
    
    static func vibrate(_ vibration: Vibration) {
        switch vibration {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        case .soft:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        case .rigid:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
