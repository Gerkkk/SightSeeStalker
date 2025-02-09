//
//  CustomImageView.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 20.01.2025.
//

import Foundation

import UIKit

final class CustomImageView: UIImageView {
    
    private enum Constants {
        static let defaultImage: String = "DefaultAvatar"
    }
    
    init(radius: CGFloat, image: UIImage?) {
        super.init(frame: .zero)
        configureUI(radius: radius, image: image)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(radius: CGFloat, image: UIImage?) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        if image == nil {
            self.image = UIImage(named: Constants.defaultImage)
        } else {
            self.image = image
        }
        
        self.setHeight(radius * 2)
        self.setWidth(radius * 2)
        self.layer.cornerRadius = (radius)
    }
}
