//
//  Font.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 20.01.2025.
//

import UIKit

extension UIFont {
    
    static let textPrimary = arialNarrow(size: 20)
    static let textSecondary = arialNarrow(size: 18)
    static let textTertiary = arialNarrow(size: 16)
    
    static func arialNarrow(size: CGFloat) -> UIFont? {
        return UIFont(name: "Arial Narrow", size: size)
    }
}
