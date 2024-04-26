//
//  UIColor.swift
//  EnergiseTest
//
//  Created by Evgeniy Zelinskiy on 26.04.2024.
//

import UIKit

public func RGBAColor(_ red: Float, _ green: Float, _ blue: Float, _ alpha: Float) -> UIColor {
    let color = UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: CGFloat(alpha))
    return color
}

public func RGBColor(_ red: Float, _ green: Float, _ blue: Float) -> UIColor {
    return RGBAColor(red, green, blue, 1.0)
}
