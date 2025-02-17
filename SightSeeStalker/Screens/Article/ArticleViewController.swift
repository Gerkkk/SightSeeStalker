//
//  ArticleViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 10.02.2025.
//

import UIKit

final class ArticleViewController: UIViewController {
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
        sv.backgroundColor = .clear
        sv.translatesAutoresizingMaskIntoConstraints = false
        //sv.contentSize = CGSize(width: 380, height: 1000)
        sv.alwaysBounceHorizontal = false
        return sv
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"ArrowLeft"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textLarge
        label.textColor = UIColor.textMain
        label.backgroundColor = .clear
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.textPrimary
        label.textColor = UIColor.textMain
        label.backgroundColor = .clear
        return label
    }()
    
    private let buttonLike: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        button.setImage(UIImage(named:"Plus"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundCol
        
        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
        
        scrollView.addSubview(backButton)
        backButton.pinLeft(to: scrollView.leadingAnchor, 10)
        backButton.pinTop(to: scrollView.topAnchor, 2)
        backButton.setWidth(20)
        backButton.setHeight(30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(nameLabel)
        nameLabel.pinTop(to: scrollView.topAnchor, 2)
        nameLabel.pinCenterX(to: scrollView.centerXAnchor)
        nameLabel.setWidth(380)
        nameLabel.setHeight(40)
        nameLabel.text = articleSelected?.title
        nameLabel.textAlignment = .center
        
        scrollView.addSubview(textLabel)
        textLabel.pinTop(to: nameLabel.bottomAnchor, 5)
        textLabel.pinCenterX(to: scrollView.centerXAnchor)
        textLabel.setWidth(380)
        textLabel.numberOfLines = 0
        textLabel.sizeToFit()
        textLabel.text = articleSelected?.text
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.textAlignment = .left
        
        lastView = textLabel
        
        if let imagesView = imagesCarousel {
            scrollView.addSubview(imagesView)
            imagesView.pinTop(to: textLabel.bottomAnchor, 10)
            imagesView.pinCenterX(to: scrollView.centerXAnchor)
            
            imagesView.setWidth(380)
            imagesView.setHeight(250)
            lastView = imagesView
        }
        
        //scrollView.contentSize = CGSize(width: 380, height: textLabel.frame.height + 40 + 200)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomY = lastView?.frame.maxY ?? 0
        print(bottomY, textLabel.frame.maxY)
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: bottomY + 50)
    }

}
