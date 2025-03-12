//
//  NewArticleViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//

import UIKit

final class NewArticleViewController: UIViewController, NewArticleViewProtocol {
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
        button.setImage(UIImage(named:"ArrowLeft"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = UIColor.customGreen
        return button
    }()
    
    private let pageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Create new article"
        label.textColor = UIColor.textMain
        label.font = UIFont.textBig
        return label
    }()
    
    private let newArticleTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.layer.cornerRadius = 10
        table.isScrollEnabled = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 200
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
        backButton.pinLeft(to: scrollView.leadingAnchor, 10)
        backButton.pinTop(to: scrollView.topAnchor, 2)
        backButton.setWidth(20)
        backButton.setHeight(30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        scrollView.addSubview(pageNameLabel)
        pageNameLabel.pinCenterX(to: scrollView)
        pageNameLabel.pinTop(to: scrollView.topAnchor, 2)
        
        scrollView.addSubview(newArticleTable)
        newArticleTable.register(UITableViewCell.self, forCellReuseIdentifier: "NewArticleTableCell")
        newArticleTable.pinTop(to: pageNameLabel.bottomAnchor, 5)
        newArticleTable.pinLeft(to: view.leadingAnchor)
        newArticleTable.pinRight(to: view.trailingAnchor)
        newArticleTable.setHeight(690)
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
        let totalHeight = pageNameLabel.frame.maxY + tableHeight + 70

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

