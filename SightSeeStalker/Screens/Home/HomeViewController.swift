//
//  PersonViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 10.02.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private enum Constants {
        static let backButtonImage = UIImage(named:"ArrowLeft")
        static let backButtonBackgrColor = UIColor.clear
        static let backButtonTintColor = UIColor.customGreen
        static let stackViewBackgrColor = UIColor.clear
        static let avatarViewRadius = CGFloat(150)
        static let avatarViewTopOffset = CGFloat(5)
        static let nameLabelFont = UIFont.textLarge
        static let nameLabelBackgroundColor = UIColor.clear
        static let nameLabelTextColor = UIColor.textMain
        static let tagLabelFont = UIFont.textBig
        static let tagLabelBackgroundColor = UIColor.clear
        static let tagLabelTextColor = UIColor.textMain
        static let statusLabelFont = UIFont.textSecondary
        static let statusLabelBackgroundColor = UIColor.clear
        static let statusLabelTextColor = UIColor.textMain
        static let statusLabelLinesNum = 0
        static let followersCountLabelFont = UIFont.textPrimary
        static let followersCountLabelBackgroundColor = UIColor.clear
        static let followersCountLabelTextColor = UIColor.textMain
        static let followButtonImage = UIImage(named: "Plus")
        static let followButtonBackgrColor = UIColor.clear
        static let followButtonTintColor = UIColor.customGreen
        static let textLabelBackgrCol = UIColor.clear
        static let textLabelTextCol = UIColor.textMain
        static let textLabelFont = UIFont.textPrimary
        static let likeButtonImage = UIImage(named:"Plus")
        static let newArtButtonImage = UIImage(named:"Plus")
        static let settingsButtonImage = UIImage(named:"Settings")
        static let likeButtonBackgrColor = UIColor.clear
        static let likeButtonTintColor = UIColor.customGreen
        static let imagesViewWidth = CGFloat(380)
        static let imagesViewHeight = CGFloat(250)
        static let backButtonHeight = CGFloat(30)
        static let backButtonWidth = CGFloat(20)
        static let backButtonTopOffset = CGFloat(2)
        static let backButtonLeadingOffset = CGFloat(10)
        static let textLabelWidth = CGFloat(380)
        static let textLabelTopOffset = CGFloat(10)
        static let textLabelNumLines = 0
        static let scrollViewDelta = CGFloat(70)
        static let nameLabelWidth = CGFloat(380)
        static let nameLabelHeight = CGFloat(40)
        static let nameLabelTopOffset = CGFloat(5)
        static let tagLabelTopOffset = CGFloat(3)
        static let vcBackgrCol = UIColor.backgroundCol
        static let tableCellRowHeight = CGFloat(430)
        static let tableCellCornerRadius = CGFloat(20)
        static let buttonFollowHeight = CGFloat(25)
        static let buttonFollowWidth = CGFloat(25)
        static let buttonFollowTrailingOffset = CGFloat(10)
        static let buttonFollowTopOffset = CGFloat(5)
        static let statusLabelLeadingOffset = CGFloat(5)
        static let statusLabelTrailingOffset = CGFloat(5)
        static let statusLabelTopOffset = CGFloat(5)
        static let defaultTag = ""
        static let follCountTrailingOffset = CGFloat(5)
        static let follCountTopOffset = CGFloat(5)
        static let postsTabelTopOffset = CGFloat(3)
        static let postsTabelLeadingOffset = CGFloat(17)
        static let follString = "FOLLOWERS"
        static let buttonFollowCornerRadius = CGFloat(10)
        static let utilityButtonHeight = CGFloat(50)
        static let utilityButtonWidth = CGFloat(50)
        static let utilityButtonTrailingOffset = CGFloat(5)
    }
    
    private var articles: [ArticleModel] = []
    var presenter: HomePresenterProtocol!
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = Constants.stackViewBackgrColor
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceHorizontal = false
        sv.clipsToBounds = false
        return sv
    }()
    
    private var titleView = UILabel()
    
    private let newArticleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.newArtButtonImage, for: .normal)
        button.backgroundColor = Constants.backButtonBackgrColor
        button.tintColor = Constants.backButtonTintColor
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.settingsButtonImage, for: .normal)
        button.backgroundColor = Constants.backButtonBackgrColor
        button.tintColor = Constants.backButtonTintColor
        return button
    }()
    
    private let avatarView: CustomImageView = CustomImageView(radius: Constants.avatarViewRadius, image: nil)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFont
        label.textColor = Constants.nameLabelTextColor
        label.backgroundColor = Constants.nameLabelBackgroundColor
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.tagLabelFont
        label.textColor = Constants.tagLabelTextColor
        label.backgroundColor = Constants.tagLabelBackgroundColor
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.statusLabelFont
        label.textColor = Constants.statusLabelTextColor
        label.backgroundColor = Constants.statusLabelBackgroundColor
        return label
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.followersCountLabelFont
        label.textColor = Constants.followersCountLabelTextColor
        label.backgroundColor = Constants.followersCountLabelBackgroundColor
        return label
    }()
    
    private let buttonFollow: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.followButtonBackgrColor
        button.tintColor = Constants.followButtonTintColor
        button.setImage(Constants.followButtonImage, for: .normal)
        return button
    }()
    
    private var postsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.rowHeight = Constants.tableCellRowHeight
        table.layer.cornerRadius = Constants.tableCellCornerRadius
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
        
        scrollView.addSubview(avatarView)
        avatarView.pinTop(to: scrollView.topAnchor, Constants.avatarViewTopOffset)
        avatarView.pinCenterX(to: scrollView)
        
        scrollView.addSubview(settingsButton)
        settingsButton.pinRight(to: scrollView.trailingAnchor, Constants.utilityButtonTrailingOffset)
        settingsButton.pinTop(to: avatarView.topAnchor)
        settingsButton.setWidth(Constants.utilityButtonWidth)
        settingsButton.setHeight(Constants.utilityButtonHeight)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(newArticleButton)
        newArticleButton.pinRight(to: scrollView.trailingAnchor, Constants.utilityButtonTrailingOffset)
        newArticleButton.pinBottom(to: avatarView.bottomAnchor)
        newArticleButton.setWidth(Constants.utilityButtonWidth)
        newArticleButton.setHeight(Constants.utilityButtonHeight)
        newArticleButton.addTarget(self, action: #selector(newArticleButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(nameLabel)
        nameLabel.pinTop(to: avatarView.bottomAnchor, Constants.nameLabelTopOffset)
        nameLabel.pinCenterX(to: scrollView)
        
        scrollView.addSubview(tagLabel)
        tagLabel.pinTop(to: nameLabel.bottomAnchor, Constants.tagLabelTopOffset)
        tagLabel.pinCenterX(to: scrollView)
        
        scrollView.addSubview(statusLabel)
        statusLabel.numberOfLines = Constants.statusLabelLinesNum
        statusLabel.pinTop(to: tagLabel.bottomAnchor)
        statusLabel.pinCenterX(to: scrollView)
        statusLabel.sizeToFit()
        statusLabel.textAlignment = .center
        statusLabel.lineBreakMode = .byWordWrapping
        statusLabel.pinLeft(to: scrollView.leadingAnchor, Constants.statusLabelLeadingOffset)
        statusLabel.pinRight(to: scrollView.trailingAnchor, Constants.statusLabelTrailingOffset)
        
        scrollView.addSubview(buttonFollow)
        buttonFollow.pinRight(to: scrollView.trailingAnchor, Constants.buttonFollowTrailingOffset)
        buttonFollow.pinTop(to: statusLabel.bottomAnchor, Constants.buttonFollowTopOffset)
        buttonFollow.layer.cornerRadius = Constants.buttonFollowCornerRadius
        buttonFollow.setHeight(Constants.buttonFollowHeight)
        buttonFollow.setWidth(Constants.buttonFollowWidth)
        
        scrollView.addSubview(followersCountLabel)
        followersCountLabel.pinRight(to: buttonFollow.leadingAnchor, Constants.follCountTrailingOffset)
        followersCountLabel.pinTop(to: statusLabel.bottomAnchor, Constants.follCountTopOffset)
        
        scrollView.addSubview(postsTable)
        postsTable.dataSource = self
        postsTable.delegate = self
        postsTable.translatesAutoresizingMaskIntoConstraints = false
        postsTable.pinTop(to: followersCountLabel.bottomAnchor, Constants.postsTabelTopOffset)
        postsTable.pinLeft(to: view.leadingAnchor, Constants.postsTabelLeadingOffset)
        postsTable.pinRight(to: view.trailingAnchor)
        postsTable.pinBottom(to: view.bottomAnchor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postsTable.layoutIfNeeded()
        let tableHeight = postsTable.contentSize.height
        let totalHeight = followersCountLabel.frame.maxY + tableHeight + Constants.scrollViewDelta
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: totalHeight)
    }
    
    @objc func newArticleButtonTapped() {
        presenter.newArticleButtonTapped()
    }
    
    @objc func settingsButtonTapped() {
        presenter.settingsButtonTapped()
    }
}

extension HomeViewController: HomeViewProtocol {
    func showUserInfo(_ user: PersonModel) {
        nameLabel.text = user.name
        tagLabel.text = "@" + (user.tag ?? Constants.defaultTag)
        statusLabel.text = user.status
        followersCountLabel.text = "\(user.followersNum ?? 0) " + Constants.follString
        
        if let avatar = user.avatar {
            avatarView.loadImage(from: Config.baseURL + avatar)
        }
    }
    
    func showArticles(_ articles: [ArticleModel]) {
        self.articles = articles
        postsTable.reloadData()
        viewDidLayoutSubviews()
    }
    
    func showError(message: String) {
        print("Error: " + message)
    }
}

extension HomeViewController: UITableViewDataSource {
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectArticle(article: articles[indexPath.row])
    }
}
