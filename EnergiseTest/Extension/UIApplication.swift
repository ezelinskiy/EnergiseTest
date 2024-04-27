//
//  UIApplication.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import Foundation
import UIKit

extension UIApplication {
    
    var foregroundActiveScene: UIWindowScene? {
        connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
    
}
