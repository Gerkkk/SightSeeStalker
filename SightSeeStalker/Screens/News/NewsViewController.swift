//
//  NewsViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit


final class NewsViewController: UIViewController, NewsViewProtocol {
    var presenter: NewsPresenterProtocol?
    
    private var Articles: [ArticleModel] = []
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.textPrimary
        nameLabel.textColor = UIColor.textMain
        return nameLabel
    }()
    
    private let newsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.rowHeight = 430
        table.layer.cornerRadius = 20
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
        newsTable.pinTop(to: nameLabel.bottomAnchor, 3)
        newsTable.pinBottom(to: view.bottomAnchor)
        newsTable.pinLeft(to: view.leadingAnchor, 17)
        newsTable.pinRight(to: view.trailingAnchor)
    }
    
    func showNews(_ articles: [ArticleModel]) {
        self.Articles.append(contentsOf: articles)
        newsTable.reloadData()
    }
}


// MARK: - UITableViewDataSource & Delegate
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseId, for: indexPath)
        guard let articleCell = cell as? ArticleCell else { return cell }
        articleCell.configure(with: Articles[indexPath.row])
        return articleCell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.didSelectArticle(Articles[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y
        let tableViewHeight = scrollView.frame.size.height
        
        if scrollPosition + tableViewHeight > contentHeight - 0 {
            presenter?.fetchNews()
        }
    }
}
