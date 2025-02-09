//
//  CustomButton.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 20.01.2025.
//

import UIKit

final class CustomButton: UIButton {
    init(cornerRadius: CGFloat, backgrCol: UIColor, imageName: String) {
        super.init(frame: .zero)
        configureUI(cornerRadius: cornerRadius, backgrCol: backgrCol, imageName: imageName)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(cornerRadius: CGFloat, backgrCol: UIColor, imageName: String) {
        self.setImage(UIImage(named: imageName), for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgrCol
    }
}

final class CustomButtonWithSizes: UIButton {
    init(height: CGFloat, width: CGFloat, cornerRadius: CGFloat, backgrCol: UIColor, imageName: String) {
        super.init(frame: .zero)
        configureUI(height: height, width: width, cornerRadius: cornerRadius, backgrCol: backgrCol, imageName: imageName)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(height: CGFloat, width: CGFloat, cornerRadius: CGFloat, backgrCol: UIColor, imageName: String) {
        self.setImage(UIImage(named: imageName), for: .normal)
        
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgrCol
        self.setHeight(height)
        self.setWidth(width)

    }
}
