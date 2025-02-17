//
//  PersonCell.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit

final class PersonCell: UITableViewCell {
    static let reuseId: String = "PersonCell"
    
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
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with person: PersonModel) {
        nameView.text = person.name!
        nameView.textColor = UIColor.textMain
        nameView.font = UIFont.textPrimary
        
        tagView.text = "@" + person.tag!
        tagView.textColor = UIColor.textSupporting
        tagView.font = UIFont.textTertiary
        
        if person.avatar! != "" {
            avatarView.loadImage(from: "http://127.0.0.1:8000" + person.avatar!)
        }
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
        
        customLabel.setHeight(80)
        customLabel.setWidth(360)
        
        avatarView.pinLeft(to: customLabel.leadingAnchor, 10)
        avatarView.pinCenterY(to: customLabel.centerYAnchor)
        
        nameView.pinLeft(to: avatarView.trailingAnchor, 10)
        nameView.pinTop(to: customLabel.topAnchor, 10)
        nameView.setWidth(320)
        nameView.setHeight(20)
        
        tagView.pinLeft(to: avatarView.trailingAnchor, 10)
        tagView.pinTop(to: nameView.bottomAnchor, 5)
        tagView.setWidth(320)
        tagView.setHeight(20)
    }
}
