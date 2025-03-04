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
    
    private let pageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Create new article"
        label.textColor = UIColor.textMain
        label.font = UIFont.textBig
        return label
    }()
    
    private let newArticleTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.layer.cornerRadius = 10
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
        table.allowsSelection = false
        return table
    }()
    
    private let carouselView: ImageFromPhoneCarouselView = {
        let view = ImageFromPhoneCarouselView(images: [])
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        
        view.addSubview(backButton)
        backButton.pinLeft(to: view.safeAreaLayoutGuide.leadingAnchor, 10)
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 2)
        backButton.setWidth(20)
        backButton.setHeight(30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(pageNameLabel)
        pageNameLabel.pinCenterX(to: view)
        pageNameLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 2)
        
        view.addSubview(newArticleTable)
        newArticleTable.register(UITableViewCell.self, forCellReuseIdentifier: "NewArticleTableCell")
        newArticleTable.pinTop(to: pageNameLabel.bottomAnchor, 5)
        newArticleTable.pinLeft(to: view.leadingAnchor, 15)
        newArticleTable.pinRight(to: view.trailingAnchor, 15)
        //newArticleTable.pinBottom(to: view.bottomAnchor)
        newArticleTable.setHeight(425)
        newArticleTable.dataSource = self
        
        view.addSubview(carouselView)
        //carouselView.pinTop(to: newArticleTable.bottomAnchor, 60)
        carouselView.pinCenterX(to: view.centerXAnchor)
        carouselView.pinBottom(to: view.bottomAnchor)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

