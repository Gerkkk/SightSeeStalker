//
//  NewArticleViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//

import UIKit

final class NewArticleViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"ArrowLeft"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backButton)
        backButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 10)
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 2)
        backButton.setWidth(20)
        backButton.setHeight(30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.backgroundColor = UIColor.backgroundCol
        
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

