//
//  CustomAnnotation.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    
    private let dotView = UIView()
    private let selectionLayer = CAShapeLayer()
    private let horizontalLinesLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        centerOffset = CGPoint(x: 0, y: 0) // Чтобы точка была над координатой
        

        dotView.frame = CGRect(x: 34, y: 34, width: 7, height: 7)
        dotView.layer.cornerRadius = 5
        dotView.backgroundColor = UIColor.customGreen
        addSubview(dotView)

        selectionLayer.fillColor = UIColor.clear.cgColor
        selectionLayer.strokeColor = UIColor.customGreen.cgColor
        selectionLayer.lineWidth = 2
        selectionLayer.isHidden = true
        layer.addSublayer(selectionLayer)
        
        horizontalLinesLayer.strokeColor = UIColor.textMain.cgColor
        horizontalLinesLayer.lineWidth = 2
        horizontalLinesLayer.isHidden = true
        layer.addSublayer(horizontalLinesLayer)
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        
        
    }
    
    func applyGradientToLayer() {
        let gradientMaskLayer = CAShapeLayer()
        gradientMaskLayer.path = horizontalLinesLayer.path
        
        gradientLayer.mask = gradientMaskLayer
        gradientLayer.frame = bounds // Чтобы градиент соответствовал размеру аннотации
        layer.addSublayer(gradientLayer) // Добавляем градиент как слой
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 0
        let rect = bounds.insetBy(dx: -padding, dy: -padding)
        
        // Основной квадрат
        let squarePath = UIBezierPath(rect: rect)
        selectionLayer.path = squarePath.cgPath
        
        
        let horizontalLinesPath = UIBezierPath()
        let lineLength: CGFloat = 75
        
        horizontalLinesPath.move(to: CGPoint(x: rect.midX, y: rect.minY))
        horizontalLinesPath.addLine(to: CGPoint(x: rect.midX, y: rect.minY - lineLength))

        horizontalLinesPath.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        horizontalLinesPath.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + lineLength))

        horizontalLinesPath.move(to: CGPoint(x: rect.minX, y: rect.midY))
        horizontalLinesPath.addLine(to: CGPoint(x: rect.minX - lineLength, y: rect.midY))


        horizontalLinesPath.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        horizontalLinesPath.addLine(to: CGPoint(x: rect.maxX + lineLength, y: rect.midY))
        horizontalLinesLayer.path = horizontalLinesPath.cgPath
        
        applyGradientToLayer()
    }
    
    override var isSelected: Bool {
        didSet {
            
            selectionLayer.isHidden = !isSelected
            horizontalLinesLayer.isHidden = !isSelected
            gradientLayer.isHidden = !isSelected
        }
    }
}

