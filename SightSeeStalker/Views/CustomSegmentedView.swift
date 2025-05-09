//
//  CustomSegmentedView.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

final class CustomSegmentedView: UISegmentedControl {
    
    private enum Constants {
        static let width: CGFloat = CGFloat(100)
        static let height: CGFloat = CGFloat(32)
        static let backgrCol: UIColor = .clear
        static let textColor = UIColor.iconNotChosen
        static let tintColor = UIColor.customGreen
    }
    
    init(data: [String], images: [UIImage]) {
        super.init(items: data)
        configureUI(data: data, images: images)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(data: [String], images: [UIImage]) {
        for i in 0...images.count - 1 {
            self.setImage(images[i], forSegmentAt: i)
        }
        
        self.setHeight(Constants.height)
        self.setWidth(Constants.width * CGFloat(data.count))
        self.backgroundColor = Constants.backgrCol
        self.selectedSegmentTintColor = Constants.tintColor
    }
}
