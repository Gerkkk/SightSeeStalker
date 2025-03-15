//
//  SettingsViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 26.02.2025.
//


import UIKit


final class SettingsViewController: UIViewController, SettingsViewProtocol {
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
        static let pageNameLabelText = "Settings"
        static let tableHeight = CGFloat(1000)
        static let tableBackgrCol = UIColor.clear
        static let tableEstimatedCellHeight = CGFloat(400)
        static let tableTopOffset = CGFloat(5)
        static let defaultSettingModel = SettingsModel(id: -1, name: "", tag: "", status: "", avatar: nil)
    }
    
    var presenter: SettingsPresenterProtocol!
    var settingsModel: SettingsModel = Constants.defaultSettingModel
    var image: UIImage?
    
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
    
    internal let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        setupScrollView()
        setupBackButton()
        setupPageNameLabel()
        setupTableView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        scrollView.pinBottom(to: view.bottomAnchor)
        scrollView.pinLeft(to: view.leadingAnchor)
        scrollView.pinRight(to: view.trailingAnchor)
    }
    
    private func setupPageNameLabel() {
        scrollView.addSubview(pageNameLabel)
        pageNameLabel.pinCenterX(to: scrollView)
        pageNameLabel.pinTop(to: scrollView.topAnchor, Constants.pageNameLabelTopOffset)
    }
    
    private func setupBackButton() {
        scrollView.addSubview(backButton)
        backButton.pinLeft(to: scrollView.leadingAnchor, Constants.backButtonLeadingOffset)
        backButton.pinTop(to: scrollView.topAnchor, Constants.backButtonTopOffset)
        backButton.setWidth(Constants.backButtonWidth)
        backButton.setHeight(Constants.backButtonHeight)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        scrollView.addSubview(tableView)
        tableView.pinTop(to: pageNameLabel.bottomAnchor, Constants.tableTopOffset)
        tableView.pinLeft(to: view.leadingAnchor)
        tableView.pinRight(to: view.trailingAnchor)
        tableView.setHeight(Constants.tableHeight)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.tableEstimatedCellHeight
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = Constants.tableBackgrCol
        tableView.tableFooterView = UIView()
    }
    
    @objc private func backButtonTapped() {
        presenter.navigateBack()
    }
    
    func updateSettings(with model: SettingsModel) {
        settingsModel = model
        tableView.reloadData()
    }
}


