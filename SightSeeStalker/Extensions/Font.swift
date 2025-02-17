//
//  Font.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 20.01.2025.
//

import UIKit

extension UIFont {
    static let textLarge = sora(size: 30)
    static let textBig = sora(size: 25)
    static let textPrimary = sora(size: 20)
    static let textSecondary = sora(size: 18)
    static let textTertiary = sora(size: 16)
    
    static func arialNarrow(size: CGFloat) -> UIFont? {
        return UIFont(name: "Arial Narrow", size: size)
    }
    
    static func sora(size: CGFloat) -> UIFont? {
        return UIFont(name: "Sora-Regular", size: size)
    }
}
