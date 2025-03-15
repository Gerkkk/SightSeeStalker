//
//  ViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 19.01.2025.
//

import UIKit

class ExploreViewController: UIViewController, ExploreViewProtocol, UITextFieldDelegate, ToggleButtonsViewDelegate {
    private enum Constants {
        static let placeHolderText = "Enter text"
        static let leftButtonText = "Authors"
        static let rightButtonText = "Places"
        static let imageChosen = UIImage(named: "Check")!
        static let imageLNotChosen = UIImage(named: "Person")!
        static let imageRNotChosen = UIImage(named: "Location")!
        static let imagePadding = CGFloat(10)
        
        static let tableLeftPadding = CGFloat(15)
        static let tableTopOffset = CGFloat(5)
        static let buttonsToggleLeadingOffset = CGFloat(5)
        static let buttonsToggleTopOffset = CGFloat(7)
        static let textFieldDefaultText = ""
        static let backgroundCol = UIColor.backgroundCol
        static let tableBackgroundColor = UIColor.clear
    }
    
    var People: [PersonModel] = []
    var Articles: [ArticleModel] = []
    var presenter: ExplorePresenterProtocol?
    
    var textField: CustomTextField = CustomTextField(initText: Constants.placeHolderText)
    var buttonsToggle: ToggleButtonsView = ToggleButtonsView(titleL: Constants.leftButtonText, imageLChosen: Constants.imageChosen, imageLNotChosen: Constants.imageLNotChosen, titleR: Constants.rightButtonText, imageRChosen: Constants.imageChosen, imageRNotChosen: Constants.imageRNotChosen, imagePadding: Constants.imagePadding)
    var table: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundCol
        
        self.configureTextField()
        self.configureButtonsToggle()
        self.configureTable()
        
        presenter?.viewDidLoad()
    }
    
    private func configureTextField() {
        view.addSubview(textField)
        textField.pinCenterX(to: view.centerXAnchor)
        textField.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = Constants.tableBackgroundColor
        table.separatorStyle = .none
        table.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseId)
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.pinTop(to: buttonsToggle.bottomAnchor, Constants.tableTopOffset)
        table.pinBottom(to: view.bottomAnchor)
        table.pinLeft(to: view.leadingAnchor, Constants.tableLeftPadding)
        table.pinRight(to: view.trailingAnchor)
    }
    
    private func configureButtonsToggle() {
        buttonsToggle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsToggle)
        buttonsToggle.pinLeft(to: textField.leadingAnchor, Constants.buttonsToggleLeadingOffset)
        buttonsToggle.pinTop(to: textField.bottomAnchor, Constants.buttonsToggleTopOffset)
        buttonsToggle.delegate = self
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter?.searchWithParams(query: textField.text ?? Constants.textFieldDefaultText, searchType: buttonsToggle.isLeftButtonSelected ? 0 : 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.searchWithParams(query: textField.text ?? Constants.textFieldDefaultText, searchType: buttonsToggle.isLeftButtonSelected ? 0 : 1)
    }
    
    func didChangeSelectedButton(isLeftButtonSelected: Bool) {
        presenter?.searchWithParams(query: textField.text ?? Constants.textFieldDefaultText, searchType: buttonsToggle.isLeftButtonSelected ? 0 : 1)
    }
    
    func setResults(articles: [ArticleModel], people: [PersonModel]) {
        self.Articles = articles
        self.People = people
    }
    
    func reloadData() {
        table.reloadData()
    }
    
    func setError(_ error: any Error) {
        print("Error" + error.localizedDescription)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
