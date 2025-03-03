//
//  PersonViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 10.02.2025.
//

import UIKit

protocol PersonViewControllerProtocol: AnyObject {
    func displayUserPosts(articles: [ArticleModel])
    func displayError(message: String)
}

final class PersonViewController: UIViewController, PersonViewControllerProtocol {
    private let interactor: PersonInteractorProtocol
    private let router: PersonRouterProtocol
    private var articles: [ArticleModel] = []
    private let person: PersonModel

    init(interactor: PersonInteractorProtocol, person: PersonModel, router: PersonRouterProtocol) {
        self.interactor = interactor
        self.person = person
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceHorizontal = false
        sv.clipsToBounds = false
        return sv
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ArrowLeft"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()

    private let avatarView: CustomImageView = CustomImageView(radius: 150, image: nil)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textLarge
        label.textColor = UIColor.textMain
        return label
    }()

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textBig
        label.textColor = UIColor.textMain
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSecondary
        label.textColor = UIColor.textMain
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textPrimary
        label.textColor = UIColor.textMain
        return label
    }()

    private let buttonFollow: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        button.setImage(UIImage(named: "Plus"), for: .normal)
        return button
    }()

    private let postsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.rowHeight = 430
        table.layer.cornerRadius = 20
        return table
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.fetchUserPosts()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollViewContentSize()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.backgroundCol

        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)

        // Back button
        scrollView.addSubview(backButton)
        backButton.pinLeft(to: scrollView.leadingAnchor, 10)
        backButton.pinTop(to: scrollView.topAnchor, 2)
        backButton.setWidth(20)
        backButton.setHeight(30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Avatar
        scrollView.addSubview(avatarView)
        avatarView.pinTop(to: scrollView.topAnchor, 5)
        avatarView.pinCenterX(to: scrollView)
        if let avatarURL = person.avatar, !avatarURL.isEmpty {
            avatarView.loadImage(from: Config.baseURL + avatarURL)
        }

        // Name Label
        scrollView.addSubview(nameLabel)
        nameLabel.text = person.name
        nameLabel.pinTop(to: avatarView.bottomAnchor, 5)
        nameLabel.pinCenterX(to: scrollView)

        // Tag Label
        scrollView.addSubview(tagLabel)
        tagLabel.text = "@" + (person.tag ?? "")
        tagLabel.pinTop(to: nameLabel.bottomAnchor, 3)
        tagLabel.pinCenterX(to: scrollView)

        // Status Label
        scrollView.addSubview(statusLabel)
        statusLabel.text = person.status
        statusLabel.pinTop(to: tagLabel.bottomAnchor, 5)
        statusLabel.pinLeft(to: view.leadingAnchor, 5)
        statusLabel.pinRight(to: view.trailingAnchor, 5)

        // Follow Button
        scrollView.addSubview(buttonFollow)
        buttonFollow.pinRight(to: view.trailingAnchor, 10)
        buttonFollow.pinTop(to: statusLabel.bottomAnchor, 5)
        buttonFollow.setHeight(25)
        buttonFollow.setWidth(25)

        // Followers Count Label
        scrollView.addSubview(followersCountLabel)
        followersCountLabel.text = "\(person.followersNum ?? 0) FOLLOWERS"
        followersCountLabel.pinRight(to: buttonFollow.leadingAnchor, 5)
        followersCountLabel.pinTop(to: statusLabel.bottomAnchor, 5)

        // Posts Table
        scrollView.addSubview(postsTable)
        postsTable.dataSource = self
        postsTable.delegate = self
        postsTable.translatesAutoresizingMaskIntoConstraints = false
        
        postsTable.pinTop(to: followersCountLabel.bottomAnchor, 3)
        postsTable.pinLeft(to: view.leadingAnchor, 17)
        postsTable.pinRight(to: view.trailingAnchor)
        postsTable.pinBottom(to: view.bottomAnchor)
    }

    private func updateScrollViewContentSize() {
        let tableHeight = postsTable.contentSize.height
        let totalHeight = followersCountLabel.frame.maxY + tableHeight + 70

        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: totalHeight)
    }

    // MARK: - Display Data
    func displayUserPosts(articles: [ArticleModel]) {
        self.articles = articles
        postsTable.reloadData()
        updateScrollViewContentSize()
    }

    func displayError(message: String) {
      print("Error: \(message)")
    }

    // MARK: - Actions
    @objc private func backButtonTapped() {
      navigationController?.popViewController(animated: true)
    }
}

extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.reuseId, for: indexPath)
        guard let articleCell = cell as? ArticleCell else { return cell }
        articleCell.configure(with: articles[indexPath.row])
        return articleCell
    }
}

extension PersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router.navigateToArticle(article: articles[indexPath.row])
    }
}
