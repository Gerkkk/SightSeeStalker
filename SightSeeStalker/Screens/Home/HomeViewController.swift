//
//  PersonViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 10.02.2025.
//

import UIKit

final class HomeViewController: UIViewController {
    public var personSelected: PersonModel
    var isUserInfoLoaded = false
    
    //TODO: ID from keychain
    init(person: PersonModel) {
        personSelected = person
        super.init(nibName: nil, bundle: nil)
        self.getUserInfo(id: personSelected.id ?? -1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var Articles: [ArticleModel] = []
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceHorizontal = false
        sv.clipsToBounds = false
        return sv
    }()
    
    private var titleView = UILabel()
    
    private let newArticleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"Plus"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"Settings"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    private let avatarView: CustomImageView = CustomImageView(radius: 150, image: nil)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textLarge
        label.textColor = UIColor.textMain
        label.backgroundColor = .clear
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textBig
        label.textColor = UIColor.textMain
        label.backgroundColor = .clear
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textSecondary
        label.textColor = UIColor.textMain
        label.backgroundColor = .clear
        return label
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textPrimary
        label.textColor = UIColor.textMain
        label.backgroundColor = .clear
        return label
    }()
    
    private let buttonFollow: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        button.setImage(UIImage(named:"Plus"), for: .normal)
        return button
    }()
    
    public var postsTable: UITableView = {
        var table = UITableView()
        table.backgroundColor = .clear
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.isScrollEnabled = true
        table.separatorStyle = .none
        table.rowHeight = 430
        table.layer.cornerRadius = 20
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundCol
        
        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
        
        scrollView.addSubview(avatarView)
        avatarView.pinTop(to: scrollView.topAnchor, 5)
        avatarView.pinCenterX(to: scrollView)
        
        if personSelected.avatar != nil {
            avatarView.loadImage(from: "http://127.0.0.1:8000" + (personSelected.avatar!))
        }
        
        scrollView.addSubview(settingsButton)
        settingsButton.pinRight(to: scrollView.trailingAnchor, 5)
        settingsButton.pinTop(to: avatarView.topAnchor)
        settingsButton.setWidth(50)
        settingsButton.setHeight(50)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(newArticleButton)
        newArticleButton.pinRight(to: scrollView.trailingAnchor, 5)
        newArticleButton.pinBottom(to: avatarView.bottomAnchor)
        newArticleButton.setWidth(50)
        newArticleButton.setHeight(50)
        newArticleButton.addTarget(self, action: #selector(newArticleButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(nameLabel)
        nameLabel.text = personSelected.name
        nameLabel.pinTop(to: avatarView.bottomAnchor, 5)
        nameLabel.pinCenterX(to: scrollView)
        
        scrollView.addSubview(tagLabel)
        tagLabel.text = "@" + (personSelected.tag ?? "")
        tagLabel.pinTop(to: nameLabel.bottomAnchor, 3)
        tagLabel.pinCenterX(to: scrollView)
        
        scrollView.addSubview(statusLabel)
        statusLabel.numberOfLines = 0
        statusLabel.pinTop(to: tagLabel.bottomAnchor)
        statusLabel.pinCenterX(to: scrollView)
        statusLabel.sizeToFit()
        statusLabel.textAlignment = .center
        statusLabel.lineBreakMode = .byWordWrapping
        statusLabel.pinLeft(to: scrollView.leadingAnchor, 5)
        statusLabel.pinRight(to: scrollView.trailingAnchor, 5)
        statusLabel.text = personSelected.status
        
        
        scrollView.addSubview(buttonFollow)
        buttonFollow.pinRight(to: scrollView.trailingAnchor, 10)
        buttonFollow.pinTop(to: statusLabel.bottomAnchor, 5)
        buttonFollow.layer.cornerRadius = 10
        buttonFollow.setHeight(25)
        buttonFollow.setWidth(25)
        
        scrollView.addSubview(followersCountLabel)
        followersCountLabel.text = String(personSelected.followersNum ?? 0) + " FOLLOWERS"
        followersCountLabel.pinRight(to: buttonFollow.leadingAnchor, 5)
        followersCountLabel.pinTop(to: statusLabel.bottomAnchor, 5)
        
        scrollView.addSubview(postsTable)
        postsTable.dataSource = self
        postsTable.delegate = self
        postsTable.translatesAutoresizingMaskIntoConstraints = false
//        postsTable.pin(to: scrollView, 15, 15)
        postsTable.pinTop(to: followersCountLabel.bottomAnchor, 3)
        //postsTable.pinBottom(to: scrollView.bottomAnchor)
        postsTable.pinLeft(to: scrollView.leadingAnchor, 17)
        postsTable.pinRight(to: scrollView.trailingAnchor)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        postsTable.layoutIfNeeded()
        
        let tableHeight = postsTable.contentSize.height

        let totalHeight = followersCountLabel.frame.maxY + tableHeight + 20
        
       // postsTable.setHeight(tableHeight)
        //print("tableHeight:", tableHeight)
        //print("followersCountLabel maxY:", followersCountLabel.frame.maxY)
        //print("scrollView frame:", scrollView.frame)
        //print("Calculated contentSize height:", totalHeight)

        scrollView.contentSize = CGSize(
            width: scrollView.frame.width,
            height: totalHeight
        )
    }
    
    @objc func newArticleButtonTapped() {
        let newArticleViewController = NewArticleViewController()
        navigationController?.pushViewController(newArticleViewController, animated: true)
    }
    
    @objc func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
