//
//  UIColor+extencion.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 22.04.2024.
//

import UIKit

extension UIColor {
    static var YPBackgroundDay: UIColor { UIColor(named: "ypBackgroundDay") ?? UIColor.darkGray }
    static var YPBackgroundNight: UIColor { UIColor(named: "ypBackgroundNight") ?? UIColor.darkGray }
    static var YPBlack: UIColor { UIColor(named: "ypBlack") ?? UIColor.black}
    static var YPBlue: UIColor { UIColor(named: "ypBlue") ?? UIColor.blue }
    static var YPGray: UIColor { UIColor(named: "ypGray") ?? UIColor.gray }
    static var YPRed: UIColor { UIColor(named: "ypRed") ?? UIColor.red }
    static var YPLightGray: UIColor { UIColor(named: "ypLightGray") ?? UIColor.lightGray }
    static var YPWhite: UIColor { UIColor(named: "ypWhite") ?? UIColor.white }
    static var YPWhiteAlpha: UIColor { UIColor(named: "ypWhiteAlpha") ?? UIColor.lightGray }
    
    static func hexString(from color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        return String.init(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
    }

    static func color(from hex: String) -> UIColor {
        var rgbValue:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
