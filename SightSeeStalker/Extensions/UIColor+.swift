//
//  UIColor+.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 20.01.2025.
//

import UIKit

extension UIColor {
    static let customGreen = UIColor(hex: "D8FE56")
    static let backgroundCol = UIColor(hex: "1F1F1F")
    static let viewColor = UIColor(hex: "1C1C1C")
    static let textMain = UIColor(hex: "FFFFFF")
    static let textSupporting = UIColor(hex: "DFD7CF")
    static let iconNotChosen = UIColor(hex: "494457")
    static let viewEdging = UIColor(hex: "000000")
    static let bottomViewBackground = UIColor(hex: "2E2C31", alpha: 0.3)
    
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r: CGFloat = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g: CGFloat = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b: CGFloat = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
