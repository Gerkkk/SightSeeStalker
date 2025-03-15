//
//  CustomAnnotation.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    private enum Constants {
        static let annotationWidth = CGFloat(75)
        static let annotationHeight = CGFloat(75)
        static let dotViewVerticalOffset = CGFloat(34)
        static let dotViewHorizontalOffset = CGFloat(34)
        static let dotViewDiameter = CGFloat(7)
        static let dotLayerCornerRadius = CGFloat(5)
        static let lineWidth = CGFloat(2)
    }
    
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
        frame = CGRect(x: 0, y: 0, width: Constants.annotationWidth, height: Constants.annotationHeight)
        centerOffset = CGPoint(x: 0, y: 0)
        
        setupDotView()
        setupSelectionLayer()
        setupHorizontalLinesLayer()
        setupGradientLayer()
    }
    
    private func setupDotView() {
        dotView.frame = CGRect(x: Constants.dotViewHorizontalOffset, y: Constants.dotViewVerticalOffset, width: Constants.dotViewDiameter, height: Constants.dotViewDiameter)
        dotView.layer.cornerRadius = Constants.dotLayerCornerRadius
        dotView.backgroundColor = UIColor.customGreen
        addSubview(dotView)
    }
    
    private func setupSelectionLayer() {
        selectionLayer.fillColor = UIColor.clear.cgColor
        selectionLayer.strokeColor = UIColor.customGreen.cgColor
        selectionLayer.lineWidth = Constants.lineWidth
        selectionLayer.isHidden = true
        layer.addSublayer(selectionLayer)
    }
    
    private func setupHorizontalLinesLayer() {
        horizontalLinesLayer.strokeColor = UIColor.textMain.cgColor
        horizontalLinesLayer.lineWidth = Constants.lineWidth
        horizontalLinesLayer.isHidden = true
        layer.addSublayer(horizontalLinesLayer)
    }
    
    private func setupGradientLayer() {
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: Constants.annotationWidth, height: Constants.annotationHeight)
    }
    
    func applyGradientToLayer() {
        let gradientMaskLayer = CAShapeLayer()
        gradientMaskLayer.path = horizontalLinesLayer.path
        gradientLayer.mask = gradientMaskLayer
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding: CGFloat = 0
        let rect = bounds.insetBy(dx: -padding, dy: -padding)
        
        let squarePath = UIBezierPath(rect: rect)
        selectionLayer.path = squarePath.cgPath
        
        
        let horizontalLinesPath = UIBezierPath()
        let lineLength: CGFloat = Constants.annotationHeight
        
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

