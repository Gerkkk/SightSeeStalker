//
//  CustomTextField.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 20.01.2025.
//

import UIKit


final class CustomTextField: UITextField {
    var wasChanged: ((Bool) -> Void)?
    var arrowView = UIImageView(image: UIImage(named: "ArrowRight"))
    var enterButton = CustomButton(cornerRadius: Constants.buttonCornerRad, backgrCol: Constants.buttonBackgrCol, imageName: Constants.buttonImageName)
    
    override func leftViewRect(forBounds: CGRect) -> CGRect {
        let leftBounds = CGRectMake(forBounds.origin.x + Constants.leftViewXOffset, Constants.leftViewYOffset, Constants.leftViewWidth, Constants.leftViewHeight)
        return leftBounds
    }
    
    override func rightViewRect(forBounds: CGRect) -> CGRect {
        let leftBounds = CGRectMake(forBounds.origin.x + Constants.textFieldWigth + Constants.rightPadding, Constants.leftViewYOffset, Constants.leftViewWidth, Constants.leftViewHeight)
        return leftBounds
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect: CGRect = super.editingRect(forBounds: bounds)
        return CGRect(x: originalRect.origin.x, y: originalRect.origin.y, width: originalRect.size.width - Constants.leftPadding - Constants.rightPadding, height: originalRect.size.height)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect: CGRect = super.editingRect(forBounds: bounds)
        return CGRect(x: originalRect.origin.x, y: originalRect.origin.y, width: originalRect.size.width - Constants.leftPadding - Constants.rightPadding, height: originalRect.size.height)
    }
    
    private enum Constants {
        static let borderWidth: CGFloat = CGFloat(8)
        static let cornerRadius: CGFloat = CGFloat(28)
        static let height: CGFloat = CGFloat(56)
        static let width: CGFloat = CGFloat(360)
        static let strokeWidth: CGFloat = CGFloat(1)
        
        static let textFieldWigth: CGFloat = CGFloat(300)
        static let leftPadding: CGFloat = CGFloat(20)
        static let rightPadding: CGFloat = CGFloat(20)
        
        static let buttonCornerRad: CGFloat = CGFloat(20)
        static let buttonBackgrCol: UIColor = .clear
        static let buttonImageName: String = "MagGlass"
        
        static let leftViewXOffset: CGFloat = CGFloat(15)
        static let leftViewYOffset: CGFloat = CGFloat(18)
        static let leftViewHeight: CGFloat = CGFloat(20)
        static let leftViewWidth: CGFloat = CGFloat(20)
        
        static let kbType: UIKeyboardType = UIKeyboardType.webSearch
        static let kbView: UIKeyboardAppearance = UIKeyboardAppearance.dark
    }
    
    init(initText: String) {
        super.init(frame: .zero)
        configureUI(initText: initText)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(initText: String) {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.viewColor
        self.layer.cornerRadius = Constants.cornerRadius
        self.setHeight(Constants.height)
        self.setWidth(Constants.width)
        self.font = UIFont.textPrimary
        self.textColor = UIColor.textSupporting
        self.placeholder = initText
        self.tintColor = UIColor.textSupporting
        
        self.layer.borderColor = UIColor.viewEdging.cgColor
        self.layer.borderWidth = Constants.strokeWidth
    
        self.keyboardAppearance = Constants.kbView
        self.keyboardType = Constants.kbType
        
        self.leftView = arrowView
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.rightView = enterButton
    }
    
    @objc
    private func textWasChanged(sender: UITextField) {
        wasChanged?(true)
    }
    
    
}
