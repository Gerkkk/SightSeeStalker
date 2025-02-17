//
//  NewsViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

class NewsViewController: UIViewController {
    var Articles: [ArticleModel] = []
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.textPrimary
        nameLabel.textColor = UIColor.textMain
        return nameLabel
    }()
    
    var newsTable: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.fetchNews()
        }
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.backgroundCol
        
        view.addSubview(nameLabel)
        nameLabel.text = "Recent trips of authors you follow"
        nameLabel.pinCenterX(to: view.centerXAnchor)
        nameLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(newsTable)
        
        newsTable.pinTop(to: nameLabel.bottomAnchor, 3)
        newsTable.pinBottom(to: view.bottomAnchor)
        newsTable.pinLeft(to: view.leadingAnchor, 17)
        newsTable.pinRight(to: view.trailingAnchor)
        //newsTable.pin(to: view, 100, 15)
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.backgroundColor = .clear
        newsTable.separatorStyle = .none
        newsTable.rowHeight = 430
        newsTable.layer.cornerRadius = 20
        newsTable.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
    }
}


