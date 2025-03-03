//
//  ViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 19.01.2025.
//

import UIKit

class ExploreViewController: UIViewController, ExploreViewProtocol, UITextFieldDelegate, ToggleButtonsViewDelegate {
    var People: [PersonModel] = []
    var Articles: [ArticleModel] = []
    var presenter: ExplorePresenterProtocol?
    
    var textField: CustomTextField = CustomTextField(initText: "Enter text")
    var buttonsToggle: ToggleButtonsView = ToggleButtonsView(titleL: "Authors", imageLChosen: UIImage(named: "Check")!, imageLNotChosen: UIImage(named: "Person")!, titleR: "Places", imageRChosen: UIImage(named: "Check")!, imageRNotChosen: UIImage(named: "Location")!, imagePadding: 10)
    var table: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundCol
        view.addSubview(textField)
        textField.pinCenterX(to: view.centerXAnchor)
        textField.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        buttonsToggle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsToggle)
        buttonsToggle.pinLeft(to: textField.leadingAnchor, 5)
        buttonsToggle.pinTop(to: textField.bottomAnchor, 7)
        buttonsToggle.delegate = self
        
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.layer.cornerRadius = 20
        table.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseId)
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.pinTop(to: buttonsToggle.bottomAnchor, 5)
        table.pinBottom(to: view.bottomAnchor)
        table.pinLeft(to: view.leadingAnchor, 15)
        table.pinRight(to: view.trailingAnchor)
        
        presenter?.viewDidLoad()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        presenter?.searchWithParams(query: textField.text ?? "", searchType: buttonsToggle.isLeftButtonSelected ? 0 : 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter?.searchWithParams(query: textField.text ?? "", searchType: buttonsToggle.isLeftButtonSelected ? 0 : 1)
    }
    
    func didChangeSelectedButton(isLeftButtonSelected: Bool) {
        presenter?.searchWithParams(query: textField.text ?? "", searchType: buttonsToggle.isLeftButtonSelected ? 0 : 1)
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
