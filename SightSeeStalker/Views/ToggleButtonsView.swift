//
//  ToggleButtonsView.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import UIKit

protocol ToggleButtonsViewDelegate: AnyObject {
    func didChangeSelectedButton(isLeftButtonSelected: Bool)
}

final class ToggleButtonsView: UIView {
    weak var delegate: ToggleButtonsViewDelegate?
    
    let buttonL = UIButton(type: .system)
    let buttonR = UIButton(type: .system)
    
    var iconLChosen = UIImage()
    var iconLNotChosen = UIImage()
    var iconRChosen = UIImage()
    var iconRNotChosen = UIImage()
    
    var dashedSublayer: CAShapeLayer = CAShapeLayer()
    
    var isLeftButtonSelected: Bool = true {
        didSet {
            delegate?.didChangeSelectedButton(isLeftButtonSelected: isLeftButtonSelected)
        }
    }
    
    private var imagePadding: CGFloat = 5.0
    
    init(titleL: String, imageLChosen: UIImage, imageLNotChosen: UIImage,
         titleR: String, imageRChosen: UIImage, imageRNotChosen: UIImage,
         imagePadding: CGFloat = 5.0) {
        super.init(frame: .zero)
        
        self.imagePadding = imagePadding
        setupView(titleL: titleL, imageLChosen: imageLChosen, imageLNotChosen: imageLNotChosen,
                  titleR: titleR, imageRChosen: imageRChosen, imageRNotChosen: imageRNotChosen)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(titleL: String, imageLChosen: UIImage, imageLNotChosen: UIImage,
                           titleR: String, imageRChosen: UIImage, imageRNotChosen: UIImage) {
        self.backgroundColor = .clear
        
        iconLChosen = imageLChosen
        iconLNotChosen = imageLNotChosen
        iconRChosen = imageRChosen
        iconRNotChosen = imageRNotChosen
        
        self.setHeight(32)
        self.setWidth(185)
        
        buttonL.addTarget(self, action: #selector(buttonLTapped), for: .touchUpInside)
        buttonR.addTarget(self, action: #selector(buttonRTapped), for: .touchUpInside)
        
        addSubview(buttonL)
        addSubview(buttonR)
        
        buttonL.translatesAutoresizingMaskIntoConstraints = false
        buttonR.translatesAutoresizingMaskIntoConstraints = false
        
        buttonL.setWidth(90)
        buttonR.setWidth(90)
        buttonL.pinLeft(to: self.leadingAnchor)
        buttonR.pinLeft(to: buttonL.trailingAnchor, 5)
        
        buttonL.pinTop(to: self.topAnchor)
        buttonL.pinBottom(to: self.bottomAnchor)
        
        buttonR.pinTop(to: self.topAnchor)
        buttonR.pinBottom(to: self.bottomAnchor)
        
        configureButton(button: buttonL, title: titleL, image: imageLChosen, color: UIColor.customGreen, tintColor: UIColor.iconNotChosen, addStroke: false)
        configureButton(button: buttonR, title: titleR, image: imageRNotChosen, color: UIColor.backgroundCol, tintColor: UIColor.customGreen, addStroke: true)
    }
    
    private func configureButton(button: UIButton, title: String, image: UIImage, color: UIColor, tintColor: UIColor, addStroke: Bool) {
        button.backgroundColor = color
        button.tintColor = tintColor
        button.layer.cornerRadius = 10
        
        let iconView = UIImageView(image: image)
        iconView.tintColor = tintColor
        iconView.setHeight(15)
        iconView.setWidth(15)
        
        let label = UILabel()
        label.text = title
        label.textColor = tintColor
        label.font = UIFont.textPrimary
        
        let stackView = UIStackView(arrangedSubviews: [iconView, label])
        stackView.axis = .horizontal
        stackView.spacing = imagePadding
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false
        
        button.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        if addStroke {
            self.dashedSublayer.removeFromSuperlayer()
            addDashedBorder(to: button)
        }
    }
    
    @objc private func buttonLTapped() {
        guard !isLeftButtonSelected else { return }
        isLeftButtonSelected = true
        updateButtonState(selectedButton: buttonL, deselectedButton: buttonR, selectedIcon: iconLChosen, deselectedIcon: iconRNotChosen)
    }
    
    @objc private func buttonRTapped() {
        guard isLeftButtonSelected else { return }
        isLeftButtonSelected = false
        updateButtonState(selectedButton: buttonR, deselectedButton: buttonL, selectedIcon: iconRChosen, deselectedIcon: iconLNotChosen)
    }

    private func updateButtonState(selectedButton: UIButton, deselectedButton: UIButton, selectedIcon: UIImage, deselectedIcon: UIImage) {
        selectedButton.backgroundColor = UIColor.customGreen
        deselectedButton.backgroundColor = UIColor.backgroundCol
        
        selectedButton.tintColor = UIColor.iconNotChosen
        deselectedButton.tintColor = UIColor.customGreen
        
        if let stackView = selectedButton.subviews.first as? UIStackView,
           let iconView = stackView.arrangedSubviews.first as? UIImageView,
           let label = stackView.arrangedSubviews.last as? UILabel {
            iconView.image = selectedIcon
            iconView.tintColor = UIColor.iconNotChosen
            label.textColor = UIColor.iconNotChosen
        }
        
        if let stackView = deselectedButton.subviews.first as? UIStackView,
           let iconView = stackView.arrangedSubviews.first as? UIImageView,
           let label = stackView.arrangedSubviews.last as? UILabel {
            iconView.image = deselectedIcon
            iconView.tintColor = UIColor.customGreen
            label.textColor = UIColor.customGreen
        }
        
        self.dashedSublayer.removeFromSuperlayer()
        addDashedBorder(to: deselectedButton)
    }
    
    func addDashedBorder(to button: UIButton) {
        button.layoutIfNeeded()
        
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.customGreen.cgColor
        borderLayer.fillColor = nil
        borderLayer.lineDashPattern = [2, 2]
        borderLayer.lineWidth = 1
        
        let path = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius)
        borderLayer.path = path.cgPath
        
        button.layer.addSublayer(borderLayer)
        
        DispatchQueue.main.async {
            borderLayer.frame = button.bounds
            borderLayer.path = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        }
        
        self.dashedSublayer = borderLayer
    }
}


