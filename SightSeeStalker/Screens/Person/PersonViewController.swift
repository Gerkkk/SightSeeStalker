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
    }
    
    private let interactor: PersonInteractorProtocol
    let router: PersonRouterProtocol
    var articles: [ArticleModel] = []
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
        sv.backgroundColor = Constants.stackViewBackgrColor
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceHorizontal = false
        sv.clipsToBounds = false
        return sv
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.backButtonImage, for: .normal)
        button.backgroundColor = Constants.backButtonBackgrColor
        button.tintColor = Constants.backButtonTintColor
        return button
    }()

    private let avatarView: CustomImageView = CustomImageView(radius: Constants.avatarViewRadius, image: nil)

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFont
        label.textColor = Constants.nameLabelTextColor
        return label
    }()

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.tagLabelFont
        label.textColor = Constants.tagLabelTextColor
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.statusLabelFont
        label.textColor = Constants.statusLabelTextColor
        label.numberOfLines = Constants.statusLabelLinesNum
        label.textAlignment = .center
        return label
    }()

    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.followersCountLabelFont
        label.textColor = Constants.followersCountLabelTextColor
        return label
    }()

    private let buttonFollow: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.followButtonBackgrColor
        button.tintColor = Constants.followButtonTintColor
        button.setImage(Constants.followButtonImage, for: .normal)
        return button
    }()

    private let postsTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.rowHeight = Constants.tableCellRowHeight
        table.layer.cornerRadius = Constants.tableCellCornerRadius
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
        backButton.pinLeft(to: scrollView.leadingAnchor, Constants.backButtonLeadingOffset)
        backButton.pinTop(to: scrollView.topAnchor, Constants.backButtonTopOffset)
        backButton.setWidth(Constants.backButtonWidth)
        backButton.setHeight(Constants.backButtonHeight)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Avatar
        scrollView.addSubview(avatarView)
        avatarView.pinTop(to: scrollView.topAnchor, Constants.avatarViewTopOffset)
        avatarView.pinCenterX(to: scrollView)
        if let avatarURL = person.avatar, !avatarURL.isEmpty {
            avatarView.loadImage(from: Config.baseURL + avatarURL)
        }

        // Name Label
        scrollView.addSubview(nameLabel)
        nameLabel.text = person.name
        nameLabel.pinTop(to: avatarView.bottomAnchor, Constants.nameLabelTopOffset)
        nameLabel.pinCenterX(to: scrollView)

        // Tag Label
        scrollView.addSubview(tagLabel)
        tagLabel.text = "@" + (person.tag ?? Constants.defaultTag)
        tagLabel.pinTop(to: nameLabel.bottomAnchor, Constants.tagLabelTopOffset)
        tagLabel.pinCenterX(to: scrollView)

        // Status Label
        scrollView.addSubview(statusLabel)
        statusLabel.text = person.status
        statusLabel.pinTop(to: tagLabel.bottomAnchor, Constants.statusLabelTopOffset)
        statusLabel.pinLeft(to: view.leadingAnchor, Constants.statusLabelLeadingOffset)
        statusLabel.pinRight(to: view.trailingAnchor, Constants.statusLabelTrailingOffset)

        // Follow Button
        scrollView.addSubview(buttonFollow)
        buttonFollow.pinRight(to: view.trailingAnchor, Constants.buttonFollowTrailingOffset)
        buttonFollow.pinTop(to: statusLabel.bottomAnchor, Constants.buttonFollowTopOffset)
        buttonFollow.setHeight(Constants.buttonFollowHeight)
        buttonFollow.setWidth(Constants.buttonFollowWidth)

        // Followers Count Label
        scrollView.addSubview(followersCountLabel)
        followersCountLabel.text = "\(person.followersNum ?? 0) " + Constants.follString
        followersCountLabel.pinRight(to: buttonFollow.leadingAnchor, Constants.follCountTrailingOffset)
        followersCountLabel.pinTop(to: statusLabel.bottomAnchor, Constants.follCountTopOffset)

        // Posts Table
        scrollView.addSubview(postsTable)
        postsTable.dataSource = self
        postsTable.delegate = self
        postsTable.translatesAutoresizingMaskIntoConstraints = false
        
        postsTable.pinTop(to: followersCountLabel.bottomAnchor, Constants.postsTabelTopOffset)
        postsTable.pinLeft(to: view.leadingAnchor, Constants.postsTabelLeadingOffset)
        postsTable.pinRight(to: view.trailingAnchor)
        postsTable.pinBottom(to: view.bottomAnchor)
    }

    private func updateScrollViewContentSize() {
        let tableHeight = postsTable.contentSize.height
        let totalHeight = followersCountLabel.frame.maxY + tableHeight + Constants.scrollViewDelta

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
