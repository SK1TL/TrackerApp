//
//  UIColor+Extencion.swift
//  TrackerApp
//
//  Created by Артур Гайфуллин on 09.06.2024.
//

import UIKit

extension UIColor {
    
    static let ypBackground = UIColor(named: "UIBackground") ?? clear
    static let ypBlack = UIColor(named: "UIBlack") ?? clear
    static let ypBlue = UIColor(named: "UIBlue") ?? clear
    static let ypGray = UIColor(named: "UIGray") ?? clear
    static let ypLightGray = UIColor(named: "UILightGray") ?? clear
    static let ypRed = UIColor(named: "UIRed") ?? clear
    static let ypWhite = UIColor(named: "UIWhite") ?? clear
    
    static let toggleBlackWhiteColor = UIColor { (traits: UITraitCollection) -> UIColor in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypBlack
        } else {
            return UIColor.ypWhite
        }
    }
    
    static let blackWhiteColorCell = UIColor { (traits: UITraitCollection) -> UIColor in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypWhite
        } else {
            return UIColor.ypBlack
        }
    }
    
    static let tabBarBorderLineColor = UIColor { (traits: UITraitCollection) -> UIColor in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypGray
        } else {
            return UIColor.ypBlack
        }
    }
    
    static let blackWhiteColorButton = UIColor { (traits: UITraitCollection) -> UIColor in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypWhite
        } else {
            return UIColor.ypBlack
        }
    }
    
    static let blackGrayColorButton = UIColor { (traits: UITraitCollection) -> UIColor in
        if traits.userInterfaceStyle == .light {
            return UIColor.ypWhite
        } else {
            return UIColor.ypBlack
        }
    }
    
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
        var hexColor: String
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        } else {
            hexColor = hex
        }
        var rgbValue:UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
