//
//  ViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 19.01.2025.
//

import UIKit

class ExploreViewController: UIViewController, UITextFieldDelegate, ToggleButtonsViewDelegate {
    var textField: CustomTextField = CustomTextField(initText: "Enter text")
//    var avatar: CustomImageView = CustomImageView(radius: 50, image: nil)
//    var buttons: CustomSegmentedView = CustomSegmentedView(data: ["places", "people"], images: [UIImage(named: "Person")!, UIImage(named: "Location")!])
    
    var buttonsToggle: ToggleButtonsView = ToggleButtonsView(titleL: "Authors", imageLChosen: UIImage(named: "Check")!, imageLNotChosen: UIImage(named: "Person")!, titleR: "Places", imageRChosen: UIImage(named: "Check")!, imageRNotChosen: UIImage(named: "Location")!, imagePadding: 10)
    
    var table: UITableView = UITableView()
    
//    var People: [PersonModel] = [PersonModel(id: 0, name: "Alex", tag: "@lol", status: "Im blue", follows: [], followersNum: 10, avatar: nil),
//        PersonModel(id: 1, name: "Bob", tag: "@lol1", status: "Im green", follows: [], followersNum: 2, avatar: nil),
//        PersonModel(id: 0, name: "Alex", tag: "@lol2", status: "Im blue", follows: [], followersNum: 10, avatar: UIImage(named: "News"))
//    ]
    
    var People: [PersonModel] = []
    var Articles: [ArticleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.backgroundCol
        view.addSubview(textField)
        textField.pinCenterX(to: view.centerXAnchor)
        textField.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        buttonsToggle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsToggle)
        buttonsToggle.pinLeft(to: textField.leadingAnchor, 5)
        buttonsToggle.pinTop(to: textField.bottomAnchor, 5)
        buttonsToggle.delegate = self
        buttonsToggle.buttonR.layoutIfNeeded()
        
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.layer.cornerRadius = 20
        table.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseId)
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        //table.setHeight(500)
        //table.setWidth(360)
        
        table.pin(to: view, 180, 15)
        
        searchWithParams()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        searchWithParams()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchWithParams()
    }
    
    func didChangeSelectedButton(isLeftButtonSelected: Bool) {
        searchWithParams()
    }
}

