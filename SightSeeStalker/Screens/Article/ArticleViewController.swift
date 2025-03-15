//
//  ArticleViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 10.02.2025.
//

import UIKit

final class ArticleViewController: UIViewController {
    private enum Constants {
        static let backButtonImage = UIImage(named:"ArrowLeft")
        static let backButtonBackgrColor = UIColor.clear
        static let backButtonTintColor = UIColor.customGreen
        static let stackViewBackgrColor = UIColor.clear
        static let nameLabelFont = UIFont.textLarge
        static let nameLabelBackgroundColor = UIColor.clear
        static let nameLabelTextColor = UIColor.textMain
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
        static let scrollViewDelta = CGFloat(50)
        static let nameLabelWidth = CGFloat(380)
        static let nameLabelHeight = CGFloat(40)
        static let nameLabelTopOffset = CGFloat(2)
        static let vcBackgrCol = UIColor.backgroundCol
    }
    
    public weak var articleSelected: ArticleModel?
    private var imagesCarousel: ImageCarouselView?
    
    private var lastView: UIView?
    
    init (article: ArticleModel) {
        super.init(nibName: nil, bundle: nil)
        self.articleSelected = article
        self.imagesCarousel = ImageCarouselView(images: articleSelected?.images ?? [])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = Constants.stackViewBackgrColor
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceHorizontal = false
        return sv
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constants.backButtonImage, for: .normal)
        button.backgroundColor = Constants.backButtonBackgrColor
        button.tintColor = Constants.backButtonTintColor
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameLabelFont
        label.textColor = Constants.nameLabelTextColor
        label.backgroundColor = Constants.nameLabelBackgroundColor
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.textLabelFont
        label.textColor = Constants.textLabelTextCol
        label.backgroundColor = Constants.textLabelBackgrCol
        return label
    }()
    
    private let buttonLike: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.likeButtonBackgrColor
        button.tintColor = Constants.likeButtonTintColor
        button.setImage(Constants.likeButtonImage, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.vcBackgrCol
        
        configureScrollView()
        configureBackButton()
        configureNameLabel()
        configureTextLabel()
        configureImagesCarousel()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
    }
    
    private func configureBackButton() {
        scrollView.addSubview(backButton)
        backButton.pinLeft(to: scrollView.leadingAnchor, Constants.backButtonLeadingOffset)
        backButton.pinTop(to: scrollView.topAnchor, Constants.backButtonTopOffset)
        backButton.setWidth(Constants.backButtonWidth)
        backButton.setHeight(Constants.backButtonHeight)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureNameLabel() {
        scrollView.addSubview(nameLabel)
        nameLabel.pinTop(to: scrollView.topAnchor, Constants.nameLabelTopOffset)
        nameLabel.pinCenterX(to: scrollView.centerXAnchor)
        nameLabel.setWidth(Constants.nameLabelWidth)
        nameLabel.setHeight(Constants.nameLabelHeight)
        nameLabel.text = articleSelected?.title
        nameLabel.textAlignment = .center
    }
    
    private func configureTextLabel() {
        scrollView.addSubview(textLabel)
        textLabel.pinTop(to: nameLabel.bottomAnchor, Constants.textLabelTopOffset)
        textLabel.pinCenterX(to: scrollView.centerXAnchor)
        textLabel.setWidth(Constants.textLabelWidth)
        textLabel.numberOfLines = Constants.textLabelNumLines
        textLabel.sizeToFit()
        textLabel.text = articleSelected?.text
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textAlignment = .left
        lastView = textLabel
    }
    
    private func configureImagesCarousel() {
        if let imagesView = imagesCarousel {
            scrollView.addSubview(imagesView)
            imagesView.pinTop(to: textLabel.bottomAnchor, Constants.textLabelTopOffset)
            imagesView.pinCenterX(to: scrollView.centerXAnchor)
            
            imagesView.setWidth(Constants.imagesViewWidth)
            imagesView.setHeight(Constants.imagesViewHeight)
            lastView = imagesView
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomY = lastView?.frame.maxY ?? 0
        print(bottomY, textLabel.frame.maxY)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: bottomY + Constants.scrollViewDelta)
    }

}
