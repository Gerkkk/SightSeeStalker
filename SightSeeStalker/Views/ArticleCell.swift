//
//  ArticleCell.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 09.02.2025.
//

import UIKit

final class ArticleCell: UITableViewCell {
    static let reuseId: String = "ArticleCell"
    
    private enum Constants {
        
    }
    
    let customLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .white
            return label
    }()
    
    private let nameView: UILabel = UILabel()
    private let tagView: UILabel = UILabel()
    private var avatarView: CustomImageView = CustomImageView(radius: 30, image: nil)
    private let articleNameView: UILabel = UILabel()
    private let briefView: UILabel = UILabel()
    private let dateView: UILabel = UILabel()
    private var articleImageView: UIImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: ArticleModel) {
        nameView.text = article.authorName ?? ""
        nameView.textColor = UIColor.textMain
        nameView.font = UIFont.textPrimary
        
        tagView.text = "@" + (article.authorTag ?? "")
        tagView.textColor = UIColor.textSupporting
        tagView.font = UIFont.textTertiary

        
        if let url = article.authorAvatar {
            avatarView.loadImage(from: "http://127.0.0.1:8000" + url)
        }
        
        if let images = article.images {
            if images.count > 0 {
                articleImageView.loadImage(from: "http://127.0.0.1:8000" + images[0])
            }
        }
        
        articleNameView.text = article.title ?? ""
        articleNameView.textColor = UIColor.textMain
        articleNameView.font = UIFont.textPrimary
        
        if let date = article.date {
            dateView.text = date.formatted(date: .long, time: .omitted)
        }
        
        dateView.textColor = UIColor.textMain
        dateView.font = UIFont.textTertiary
        
        briefView.text = article.brief ?? ""
        briefView.textColor = UIColor.textMain
        briefView.font = UIFont.textTertiary
        briefView.numberOfLines = 0
        briefView.sizeToFit()
        briefView.lineBreakMode = .byWordWrapping
    }
    
    private func configureUI() {
        backgroundColor = .clear
        contentView.addSubview(customLabel)
        contentView.backgroundColor = .clear
        
        selectionStyle = .none
        customLabel.backgroundColor = UIColor.viewColor
        customLabel.layer.cornerRadius = 20
        customLabel.layer.borderColor = UIColor.viewEdging.cgColor
        customLabel.layer.borderWidth = 1
    
        customLabel.addSubview(nameView)
        customLabel.addSubview(tagView)
        customLabel.addSubview(avatarView)
        customLabel.addSubview(articleImageView)
        customLabel.addSubview(articleNameView)
        customLabel.addSubview(dateView)
        customLabel.addSubview(briefView)
        
        customLabel.setHeight(430)
        customLabel.setWidth(360)
        
        avatarView.pinTop(to: customLabel.topAnchor, 10)
        avatarView.pinLeft(to: customLabel.leadingAnchor, 10)
        
        nameView.pinLeft(to: avatarView.trailingAnchor, 10)
        nameView.pinTop(to: customLabel.topAnchor, 10)
        nameView.setWidth(300)
        nameView.setHeight(20)
        
        tagView.pinLeft(to: avatarView.trailingAnchor, 10)
        tagView.pinTop(to: nameView.bottomAnchor, 5)
        tagView.setWidth(300)
        tagView.setHeight(20)
        
        articleImageView.pinLeft(to: customLabel.leadingAnchor)
        articleImageView.pinTop(to: avatarView.bottomAnchor, 5)
        articleImageView.setWidth(360)
        articleImageView.setHeight(190)
        
        articleNameView.pinLeft(to: customLabel.leadingAnchor, 10)
        articleNameView.pinTop(to: articleImageView.bottomAnchor, 5)
        articleNameView.setWidth(320)
        articleNameView.setHeight(20)
        
        dateView.pinLeft(to: customLabel.leadingAnchor, 10)
        dateView.pinTop(to: articleNameView.bottomAnchor, 7)
        dateView.setWidth(300)
        dateView.setHeight(20)
        
        briefView.pinLeft(to: customLabel.leadingAnchor, 10)
        briefView.pinTop(to: dateView.bottomAnchor, 7)
        briefView.setWidth(360)
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameView.text = nil
        tagView.text = nil
        avatarView.image = nil
        articleImageView.image = nil
        articleNameView.text = nil
        dateView.text = nil
        briefView.text = nil
    }
}

