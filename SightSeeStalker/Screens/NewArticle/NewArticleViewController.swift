//
//  NewArticleViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//

import UIKit

final class NewArticleViewController: UIViewController, NewArticleViewProtocol {
    private enum Constants {
        static let backButtonImage = UIImage(named: "ArrowLeft")
        static let backButtonBackgrCol = UIColor.clear
        static let backButtonTintColor = UIColor.customGreen
        static let backButtonHeight = CGFloat(30)
        static let backButtonWidth = CGFloat(20)
        static let backButtonTopOffset = CGFloat(2)
        static let backButtonLeadingOffset = CGFloat(10)
        static let vcBackgrCol = UIColor.backgroundCol
        static let pageNameLabelTopOffset = CGFloat(2)
        static let pageNameLabelFont = UIFont.textBig
        static let pageNameLabelTextColor = UIColor.textMain
        static let pageNameLabelText = "Create new article"
        static let tableHeight = CGFloat(690)
        static let tableBackgrCol = UIColor.clear
        static let tableEstimatedCellHeight = CGFloat(200)
        static let tableCornerRadius = CGFloat(10)
        static let tableTopOffset = CGFloat(5)
        static let scrollViewDelta = CGFloat(70)
    }
    
    var presenter: NewArticlePresenterProtocol!
    
    public weak var imageCarousel: ImageFromPhoneCarouselView?
    public weak var nameField: UITextField?
    public weak var datePicker: UIDatePicker?
    public weak var coordNField: UITextField?
    public weak var coordWField: UITextField?
    public weak var briefView: UITextView?
    public weak var textView: UITextView?
    
    
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
        button.setImage(Constants.backButtonImage, for: .normal)
        button.backgroundColor = Constants.backButtonBackgrCol
        button.tintColor = Constants.backButtonTintColor
        return button
    }()
    
    private let pageNameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.pageNameLabelText
        label.textColor = Constants.pageNameLabelTextColor
        label.font = Constants.pageNameLabelFont
        return label
    }()
    
    private let newArticleTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.tableBackgrCol
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = Constants.tableEstimatedCellHeight
        table.allowsSelection = false
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
        
        
        scrollView.addSubview(backButton)
        backButton.pinLeft(to: scrollView.leadingAnchor, Constants.backButtonLeadingOffset)
        backButton.pinTop(to: scrollView.topAnchor, Constants.backButtonTopOffset)
        backButton.setWidth(Constants.backButtonWidth)
        backButton.setHeight(Constants.backButtonHeight)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(pageNameLabel)
        pageNameLabel.pinCenterX(to: scrollView)
        pageNameLabel.pinTop(to: scrollView.topAnchor, Constants.pageNameLabelTopOffset)
        
        scrollView.addSubview(newArticleTable)
        newArticleTable.register(UITableViewCell.self, forCellReuseIdentifier: "NewArticleTableCell")
        newArticleTable.pinTop(to: pageNameLabel.bottomAnchor, Constants.tableTopOffset)
        newArticleTable.pinLeft(to: view.leadingAnchor)
        newArticleTable.pinRight(to: view.trailingAnchor)
        newArticleTable.setHeight(Constants.tableHeight)
        newArticleTable.dataSource = self
        
        updateScrollViewContentSize()
    }
    
    @objc private func backButtonTapped() {
        presenter.backButtonTapped()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func updateScrollViewContentSize() {
        let tableHeight = newArticleTable.contentSize.height
        let totalHeight = pageNameLabel.frame.maxY + tableHeight + Constants.scrollViewDelta

        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: totalHeight)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollViewContentSize()
    }
    
    func updateView() {
        newArticleTable.reloadData()
    }
}

