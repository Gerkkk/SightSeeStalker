//
//  NewsViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit


final class NewsViewController: UIViewController, NewsViewProtocol {
    private enum Constants {
        static let tableRowHeight = CGFloat(430)
        static let tableCellCornerRadius = CGFloat(20)
        static let tableLeadingOffset = CGFloat(17)
        static let tableTopOffset = CGFloat(3)
    }
    
    var presenter: NewsPresenterProtocol?
    
    var Articles: [ArticleModel] = []
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.textPrimary
        nameLabel.textColor = UIColor.textMain
        return nameLabel
    }()
    
    let newsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.rowHeight = Constants.tableRowHeight
        table.layer.cornerRadius = Constants.tableCellCornerRadius
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter?.fetchNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.dropValues()
        Articles = []
        presenter?.fetchNews()
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.backgroundCol
        view.addSubview(nameLabel)
        view.addSubview(newsTable)
        
        nameLabel.text = "Recent trips of authors you follow"
        nameLabel.pinCenterX(to: view.centerXAnchor)
        nameLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.pinTop(to: nameLabel.bottomAnchor, Constants.tableTopOffset)
        newsTable.pinBottom(to: view.bottomAnchor)
        newsTable.pinLeft(to: view.leadingAnchor, Constants.tableLeadingOffset)
        newsTable.pinRight(to: view.trailingAnchor)
    }
    
    func showNews(_ articles: [ArticleModel]) {
        self.Articles.append(contentsOf: articles)
        newsTable.reloadData()
    }
}
